#!/usr/bin/env sh

snap list emacs >/dev/null 2>&1 || sudo snap install emacs --channel=pgtk --classic
