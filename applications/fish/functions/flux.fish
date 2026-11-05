function flux
    set exec_source_dir $PWD

    cd $FLUX/utilities
    lua flux.lua $argv
    cd $exec_source_dir
end