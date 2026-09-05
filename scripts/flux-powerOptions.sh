#!/bin/sh

cleanup() {
    kill "$QS_PID"
}

trap cleanup INT TERM
QML_IMPORT_PATH="$FLUX/shell" zsh -c "exec -a flux-powerOptions qs -p $FLUX/shell/powerOptions/shell.qml" &

QS_PID=$!
wait "$QS_PID"

