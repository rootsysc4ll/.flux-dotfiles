function flux-theme
    set exec_source_dir $PWD

    cd $FLUX/theme
    lua flux-theme.lua $argv
    cd $exec_source_dir
end