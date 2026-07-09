#!/usr/bin/env sh

# Language servers and debuggers for init.el's extras
# (clojure, cpp, elixir, erlang, go, java, python, rust, scheme, typescript, zig).
# Runtimes come from mise (go, node, erlang, elixir) and rustup (cargo);
# tree-sitter grammars are installed inside Emacs
# (M-x treesit-install-language-grammar).

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

# scheme: Guile (the geiser default — Ubuntu's guile-3.0, also in apt.sh's base
# set, provides plain `guile' via alternatives, exactly geiser-guile's default
# binary; guile-3.0-doc feeds geiser's Info-manual lookup) + Chez for SICP.
# Ubuntu ships Chez as `chezscheme' (extras/scheme.el sets geiser-chez-binary to
# match); scheme-mode, geiser and paredit are built-in / NonGNU ELPA, installed
# by Emacs.
sudo apt install -y guile-3.0 guile-3.0-doc chezscheme

# elixir / erlang (BEAM): runtimes via mise. Erlang compiles from source, so
# install the OTP build deps first (minimal headless set — for the GUI observer
# / debugger add libwxgtk3.2-dev libgl1-mesa-dev). Elixir is precompiled and
# pairs with the mise Erlang; mise's erl/elixir shims are already on PATH above.
sudo apt install -y autoconf m4 libncurses-dev libssl-dev
mise use -g erlang@latest
mise use -g elixir@latest

# elixir: ElixirLS — its `language_server.sh' (found by eglot) and
# `debug_adapter.sh' (used by extras/elixir.el's dape config) go on PATH via
# ~/.local/bin. The release zip is flat, so it unzips straight into
# ~/.local/share/elixir-ls; guarded like jdtls — remove that dir to re-pull.
mkdir -p "$HOME/.local/share/elixir-ls" "$HOME/.local/bin"
if [ ! -x "$HOME/.local/share/elixir-ls/language_server.sh" ]; then
    curl -fsSL "$(curl -fsSL https://api.github.com/repos/elixir-lsp/elixir-ls/releases/latest | grep -o 'https://[^"]*elixir-ls-v[^"]*\.zip' | head -n 1)" -o "$HOME/.local/share/elixir-ls/elixir-ls.zip"
    unzip -q -o "$HOME/.local/share/elixir-ls/elixir-ls.zip" -d "$HOME/.local/share/elixir-ls"
    rm -f "$HOME/.local/share/elixir-ls/elixir-ls.zip"
    chmod +x "$HOME/.local/share/elixir-ls/language_server.sh" "$HOME/.local/share/elixir-ls/debug_adapter.sh"
fi
ln -sf "$HOME/.local/share/elixir-ls/language_server.sh" "$HOME/.local/bin/language_server.sh"
ln -sf "$HOME/.local/share/elixir-ls/debug_adapter.sh" "$HOME/.local/bin/debug_adapter.sh"

# erlang: erlang_ls — prebuilt binary matched to the installed OTP major (the
# release ships one per OTP 24-27) into ~/.local/bin; fall back to the newest
# linux build if that major isn't published yet.
if [ ! -x "$HOME/.local/bin/erlang_ls" ] && ! command -v erlang_ls >/dev/null 2>&1; then
    OTP=$(erl -noshell -eval 'io:format("~s", [erlang:system_info(otp_release)])' -s init stop 2>/dev/null | tr -dc 0-9)
    ELS_RELEASES=$(curl -fsSL https://api.github.com/repos/erlang-ls/erlang_ls/releases/latest)
    ELS_URL=$(printf '%s' "$ELS_RELEASES" | grep -o "https://[^\"]*erlang_ls-linux-${OTP}\.tar\.gz" | head -n 1)
    [ -n "$ELS_URL" ] || ELS_URL=$(printf '%s' "$ELS_RELEASES" | grep -o 'https://[^"]*erlang_ls-linux-[0-9]*\.tar\.gz' | sort -V | tail -n 1)
    [ -n "$ELS_URL" ] && curl -fsSL "$ELS_URL" | tar -xz -C "$HOME/.local/bin"
fi

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
