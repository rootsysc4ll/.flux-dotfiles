#!/bin/sh

cleanup() {
    kill "$QS_PID"
}

trap cleanup INT TERM
QML_IMPORT_PATH="$FLUX/shell" zsh -c "exec -a flux-bar qs -p $FLUX/shell/bar/shell.qml" &

QS_PID=$!
wait "$QS_PID"
