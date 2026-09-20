function flux-bar
    if not pgrep -f flux-bar | grep -v $fish_pid | xargs kill
        QML_IMPORT_PATH="$FLUX/shell" sh -c "exec -a flux-bar qs -p $FLUX/shell/bar/shell.qml" &
    end
end