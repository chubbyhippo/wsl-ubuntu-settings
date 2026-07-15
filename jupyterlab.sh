#!/usr/bin/env sh

# JupyterLab in its own venv (~/.local/share/jupyterlab) with the
# jupytermeow modal-editing extension built and installed into it.
# JupyterLab is pinned to 4.6.1 — the version jupytermeow's command ids
# are verified against; bump both together. Rerun any time: the venv and
# clone are kept, the suite/build/install run fresh.

# mise + local bin on PATH, so node/npm and the mise python (from
# mise.toml's global tool set) resolve when piped into sh
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"

JUPYTERLAB_VERSION=4.6.1
VENV="$HOME/.local/share/jupyterlab"
SRC="$HOME/projects/jupytermeow"

[ -d "$VENV" ] || python3 -m venv "$VENV"
"$VENV/bin/pip" install --quiet --upgrade pip
"$VENV/bin/pip" install --quiet "jupyterlab==$JUPYTERLAB_VERSION"

# launchers on PATH (.bashrc has ~/.local/bin)
mkdir -p "$HOME/.local/bin"
ln -sf "$VENV/bin/jupyter" "$HOME/.local/bin/jupyter"
ln -sf "$VENV/bin/jupyter-lab" "$HOME/.local/bin/jupyter-lab"

# jupytermeow: clone once, then its setup.sh runs the behavior suite,
# builds the prebuilt lab extension, and pip-installs it into whichever
# environment owns the `jupyter` on PATH — the venv above, thanks to the
# PATH prepend
mkdir -p "$HOME/projects"
[ -d "$SRC" ] || git clone https://github.com/chubbyhippo/jupytermeow.git "$SRC"
PATH="$VENV/bin:$PATH" sh "$SRC/setup.sh"
