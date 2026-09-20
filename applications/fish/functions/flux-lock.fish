function flux-lock
    if not pgrep -f flux-lock | grep -v $fish_pid | xargs kill
        QML_IMPORT_PATH="$FLUX/shell" sh -c "exec -a flux-lock qs -p $FLUX/shell/lock/shell.qml" &
    end
end