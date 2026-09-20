function flux-powerOptions
    if not pgrep -f flux-powerOptions | grep -v $fish_pid | xargs kill
        QML_IMPORT_PATH="$FLUX/shell" sh -c "exec -a flux-powerOptions qs -p $FLUX/shell/powerOptions/shell.qml" &
    end
end