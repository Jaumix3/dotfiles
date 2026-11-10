-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Commands and Apps to be executed at launch. Lua twin of Startup_Apps.conf

local v = require("configs.Vars")
local scriptsDir = v.scriptsDir
local UserScripts = v.UserScripts
local wallDIR = os.getenv("HOME") .. "/Pictures/wallpapers"
local SwwwRandom = UserScripts .. "/WallpaperAutoChange.sh"
local livewallpaper = ""

hl.on("hyprland.start", function()
    -- wallpaper stuff. swww was renamed to awww, start whichever is installed.
    hl.exec_cmd("command -v awww-daemon >/dev/null && awww-daemon --format xrgb || swww-daemon --format xrgb")
    -- hl.exec_cmd("mpvpaper '*' -o \"load-scripts=no no-audio --loop\" " .. livewallpaper)

    -- wallpaper random
    -- hl.exec_cmd(SwwwRandom .. " " .. wallDIR) -- random wallpaper switcher every 30 minutes

    -- Startup
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Initialize dropdown terminal
    hl.exec_cmd(scriptsDir .. "/Dropterminal.sh kitty")

    -- Polkit (Polkit Gnome / KDE)
    hl.exec_cmd(scriptsDir .. "/Polkit.sh")

    -- starup apps
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("swaync")
    -- hl.exec_cmd("ags")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("rog-control-center")
    hl.exec_cmd("waybar")
    hl.exec_cmd("qs") -- quickshell AGS Desktop Overview alternative

    -- Clipboard manager
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Starting hypridle to start hyprlock
    hl.exec_cmd("hypridle")
end)
