-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Window rules and layer rules. Lua twin of WindowRules.conf
-- See https://wiki.hypr.land/Configuring/Window-Rules/
-- NOTE: a `negative:` prefix in a match field inverts the regex.
-- NOTE: `tag` matches one exact tag name (no regex), so rules for several tags are
-- written as one rule per tag.

local function rule(match, effects)
    effects.match = match
    return hl.window_rule(effects)
end

-- ### TAGS ###
local tags = {
    browser = {
        { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$" },
        { class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" },
        { class = "^(chrome-.+-Default)$" }, -- Chrome PWAs
        { class = "^([Cc]hromium)$" },
        { class = "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$" },
        { class = "^(Brave-browser(-beta|-dev|-unstable)?)$" },
        { class = "^([Tt]horium-browser|[Cc]achy-browser)$" },
        { class = "^(zen-alpha|zen)$" },
    },
    notif = { { class = "^(swaync-control-center|swaync-notification-window|swaync-client)$" } },
    KooL_Cheat = { { title = "^(KooL Quick Cheat Sheet)$" } },
    KooL_Settings = { { title = "^(KooL Hyprland Settings)$" } },
    ["KooL-Settings"] = { { class = "^(nwg-displays|nwg-look)$" } },
    terminal = { { class = "^(Alacritty|kitty|kitty-dropterm)$" } },
    email = { { class = "^([Tt]hunderbird|org.gnome.Evolution|eu.betterbird.Betterbird)$" } },
    projects = { { class = "^(codium|codium-url-handler|VSCodium|VSCode|code-url-handler|jetbrains-.+)$" } },
    screenshare = { { class = "^(com.obsproject.Studio)$" } },
    im = { { class = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop|[Ff]erdium|[Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap|org.telegram.desktop|io.github.tdesktop_x64.TDesktop|teams-for-linux|im.riot.Riot|Element)$" } },
    games = { { class = "^(gamescope|steam_app_\\d+)$" } },
    gamestore = {
        { class = "^([Ss]team|com.heroicgameslauncher.hgl)$" },
        { title = "^([Ll]utris)$" },
    },
    ["file-manager"] = { { class = "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt|app.drey.Warp)$" } },
    wallpaper = { { class = "^([Ww]aytrogen)$" } },
    multimedia = { { class = "^([Aa]udacious)$" } },
    multimedia_video = { { class = "^([Mm]pv|vlc)$" } },
    settings = {
        { title = "^(ROG Control|Kvantum Manager)$" },
        { class = "^(wihotspot(-gui)?|gnome-disks|file-roller|org.gnome.FileRoller|nm-applet|nm-connection-editor|blueman-manager|pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol|qt5ct|qt6ct|[Yy]ad|xdg-desktop-portal-gtk|org.kde.polkit-kde-authentication-agent-1|[Rr]ofi)$" },
        { class = "^([Bb]aobab|org.gnome.[Bb]aobab)$" },
    },
    viewer = { { class = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter|evince|eog|org.gnome.Loupe)$" } },
}
-- Tags are applied before the rules that match on them.
for tag, matches in pairs(tags) do
    for _, match in ipairs(matches) do
        rule(match, { tag = "+" .. tag })
    end
end

-- POSITION
rule({ tag = "KooL_Cheat" }, { center = true })
rule({ class = "^([Tt]hunar)$", title = "negative:(.*[Tt]hunar.*)" }, { center = true })
rule({ title = "^(ROG Control|Keybindings)$" }, { center = true })
rule({ tag = "KooL-Settings" }, { center = true })
rule({ class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol|[Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap|[Ff]erdium)$" }, { center = true })
rule({ title = "^(Picture-in-Picture)$" }, { move = "(monitor_w*0.72) (monitor_h*0.07)" })

-- idle inhibit while watching videos
rule({ fullscreen = true }, { idle_inhibit = "fullscreen" })

-- windowrule to move to workspace
rule({ tag = "email" }, { workspace = "1" })
rule({ tag = "browser" }, { workspace = "2" })
rule({ tag = "gamestore" }, { workspace = "5" })
rule({ tag = "im" }, { workspace = "7" })
rule({ tag = "games" }, { workspace = "8" })

-- windowrule to move to workspace (silent)
rule({ tag = "screenshare" }, { workspace = "4 silent" })
rule({ class = "^(virt-manager|.virt-manager-wrapped)$" }, { workspace = "6 silent" })
rule({ tag = "multimedia" }, { workspace = "9 silent" })

-- FLOAT
for _, tag in ipairs({ "KooL_Cheat", "wallpaper", "settings", "viewer", "KooL-Settings" }) do
    rule({ tag = tag }, { float = true })
end
rule({ class = "([Zz]oom|onedriver|onedriver-launcher)$" }, { float = true })
rule({ class = "org.gnome.Calculator", title = "(Calculator)" }, { float = true })
rule({ class = "^(mpv|com.github.rafostar.Clapper|[Qq]alculate-gtk|[Ff]erdium)$" }, { float = true })
rule({ title = "^(Picture-in-Picture)$" }, { float = true })
rule({ title = "^(Authentication Required)$" }, { float = true, center = true })
rule({ class = "(codium|codium-url-handler|VSCodium)$", title = "negative:(.*codium.*|.*VSCodium.*)" }, { float = true })
rule({ class = "^([Ss]team)$", title = "negative:^([Ss]team)$" }, { float = true })
rule({ class = "^([Tt]hunar)$", title = "negative:(.*[Tt]hunar.*)" }, { float = true })
rule({ title = "^(Add Folder to Workspace|Save As|Open Files|SDDM Background)$" }, { float = true })
rule({ title = "^(Add Folder to Workspace|Save As|Open Files)$" }, { size = "(monitor_w*0.7) (monitor_h*0.6)" })
rule({ title = "^(Add Folder to Workspace|Save As|SDDM Background)$" }, { center = true })
rule({ title = "^(SDDM Background)$" }, { size = "(monitor_w*0.16) (monitor_h*0.12)" })

-- SIZE
rule({ tag = "KooL_Cheat" }, { size = "(monitor_w*0.65) (monitor_h*0.9)" })
rule({ tag = "wallpaper" }, { size = "(monitor_w*0.7) (monitor_h*0.7)" })
rule({ tag = "settings" }, { size = "(monitor_w*0.7) (monitor_h*0.7)" })
rule({ class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap|[Ff]erdium)$" }, { size = "(monitor_w*0.6) (monitor_h*0.7)" })

-- PINNING
rule({ title = "^(Picture-in-Picture)$" }, { pin = true, keep_aspect_ratio = true })

-- BLUR & FULLSCREEN
rule({ tag = "games" }, { no_blur = true, fullscreen = true })

-- NO INITIAL FOCUS
rule({ class = "^(jetbrains-.*)$" }, { no_initial_focus = true })
rule({ title = "^(wind.*)$" }, { no_initial_focus = true })

-- LAYER RULES
local function layer(namespace, effects)
    effects.match = { namespace = namespace }
    return hl.layer_rule(effects)
end

layer("rofi", { blur = true, ignore_alpha = 0 })
layer("notifications", { blur = true, ignore_alpha = 0 })
layer("quickshell:overview", { blur = true, ignore_alpha = 0.5 })
