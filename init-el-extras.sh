#!/usr/bin/env sh

# Language servers and debuggers for init.el's extras
# (clojure, cpp, go, java, python, rust, typescript, zig).
# Runtimes come from mise (go, node) and rustup (cargo); tree-sitter grammars
# are installed inside Emacs (M-x treesit-install-language-grammar).

# mise + local bin on PATH, so go/npm/mise resolve when piped into sh
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"

# cpp: clangd + gdb (gdb speaks DAP natively since 14.1)
sudo apt install clangd -y
sudo apt install gdb -y

# rust/zig debugging: lldb-dap — the dape configs launch it by that name,
# so symlink the versioned binary if the packages only ship lldb-dap-<N>
sudo apt install lldb -y
if ! command -v lldb-dap >/dev/null 2>&1; then
    set -- /usr/bin/lldb-dap-*
    [ -x "$1" ] && sudo ln -sf "$1" /usr/local/bin/lldb-dap
fi

# python: pylsp + debugpy for the system python (venv projects add their own debugpy)
sudo apt install python3-pylsp -y
sudo apt install python3-debugpy -y

# clojure: clojure-lsp (CIDER itself needs only the JVM + lein)
command -v clojure-lsp >/dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install | sudo bash

# go: gopls + delve, installed to ~/go/bin (.bashrc puts it on PATH)
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest

# java: jdtls (Eclipse JDT language server) + the java-debug plugin jar
# that extras/java.el loads into it for dape debugging. Both are guarded:
# re-extracting a newer jdtls snapshot (or re-downloading a newer plugin)
# over an old one leaves two versions of the same bundles side by side.
mkdir -p "$HOME/.local/share/jdtls" "$HOME/.local/share/java-debug" "$HOME/.local/bin"
[ -x "$HOME/.local/share/jdtls/bin/jdtls" ] || curl -fsSL https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz | tar -xz -C "$HOME/.local/share/jdtls"
ln -sf "$HOME/.local/share/jdtls/bin/jdtls" "$HOME/.local/bin/jdtls"
if ! ls "$HOME"/.local/share/java-debug/com.microsoft.java.debug.plugin-*.jar >/dev/null 2>&1; then
    JAVA_DEBUG_VERSION=$(curl -fsSL https://repo1.maven.org/maven2/com/microsoft/java/com.microsoft.java.debug.plugin/maven-metadata.xml | grep -o '<latest>[^<]*' | cut -d '>' -f 2)
    curl -fsSL "https://repo1.maven.org/maven2/com/microsoft/java/com.microsoft.java.debug.plugin/$JAVA_DEBUG_VERSION/com.microsoft.java.debug.plugin-$JAVA_DEBUG_VERSION.jar" -o "$HOME/.local/share/java-debug/com.microsoft.java.debug.plugin-$JAVA_DEBUG_VERSION.jar"
fi

# rust: rust-analyzer, managed by rustup like the rest of the toolchain
rustup component add rust-analyzer

# typescript: the language server + the vscode-js-debug adapter dape looks for
# in ~/.config/emacs/debug-adapters/js-debug
npm install -g typescript typescript-language-server
mkdir -p "$HOME/.config/emacs/debug-adapters"
[ -d "$HOME/.config/emacs/debug-adapters/js-debug" ] || curl -fsSL "$(curl -fsSL https://api.github.com/repos/microsoft/vscode-js-debug/releases/latest | grep -o 'https://[^"]*js-debug-dap[^"]*\.tar\.gz' | head -n 1)" | tar -xz -C "$HOME/.config/emacs/debug-adapters"

# zig: compiler + zls
mise use -g zig@latest
mise use -g zls@latest
