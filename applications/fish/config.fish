if status is-interactive
    set -g fish_greeting
    fastfetch
    # Commands to run in interactive sessions can go here

    # to start the hyprland session
    if uwsm check may-start
        ~/.flux-dotfiles/scripts/start.sh
    end

    # aliases
    alias        ..="cd .."
    alias         l="ls -la"
    alias fastfetch="fastfetch -c $FLUX/applications/fastfetch/config.jsonc"
end
