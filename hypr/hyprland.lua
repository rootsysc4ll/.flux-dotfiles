-- https://wiki.hypr.land/Configuring/Start/
require("utils.Theme")

require("modules.monitors")
require("modules.myPrograms")
require("modules.autostart")
require("modules.envVars")
require("modules.decorations")
require("modules.windowRules")
require("modules.input")
require("modules.keybindings")
require("modules.layouts")

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
