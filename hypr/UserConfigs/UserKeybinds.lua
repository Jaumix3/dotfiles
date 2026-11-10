-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- This is where you put your own keybinds. Be Mindful to check as well ~/.config/hypr/configs/Keybinds.lua to avoid conflict
-- if you think I should replace the Pre-defined Keybinds in ~/.config/hypr/configs/Keybinds.lua , submit an issue or let me know in DC and present me a valid reason as to why, such as conflicting with global shortcuts, etc etc
-- Lua twin of UserKeybinds.conf

local v = require("configs.Vars")
local d = require("UserConfigs.01-UserDefaults")
local mainMod = v.mainMod
local scriptsDir = v.scriptsDir
local UserScripts = v.UserScripts

local function exec(cmd) return hl.dsp.exec_cmd(cmd) end
local function bind(keys, dsp, opts) return hl.bind(keys, dsp, opts) end

-- rofi App launcher
bind(mainMod .. " + D", exec("pkill rofi || true && rofi -show drun -modi drun,filebrowser,run,window")) -- Main Menu (APP Launcher)
bind(mainMod .. " + B", exec("xdg-open \"https://\""))  -- default browser
bind(mainMod .. " + A", hl.dsp.global("quickshell:overviewToggle")) -- desktop overview (quickshell)
bind(mainMod .. " + Return", exec(d.term))  -- terminal
bind(mainMod .. " + T", exec(d.files))      -- file manager

-- FEATURES / EXTRAS
bind(mainMod .. " + H", exec(scriptsDir .. "/KeyHints.sh"))             -- help / cheat sheet
bind(mainMod .. " + ALT + R", exec(scriptsDir .. "/Refresh.sh"))        -- Refresh waybar, swaync, rofi
bind(mainMod .. " + ALT + E", exec(scriptsDir .. "/RofiEmoji.sh"))      -- emoji menu
bind(mainMod .. " + S", exec(scriptsDir .. "/RofiSearch.sh"))           -- Google search using rofi
bind(mainMod .. " + CTRL + S", exec("rofi -show window"))              -- list/switch apps using rofi
bind(mainMod .. " + ALT + O", exec(scriptsDir .. "/ChangeBlur.sh"))     -- Toggle blur settings
bind(mainMod .. " + SHIFT + G", exec(scriptsDir .. "/GameMode.sh"))     -- Toggle animations ON/OFF
bind(mainMod .. " + ALT + L", exec(scriptsDir .. "/ChangeLayout.sh"))   -- Toggle Master or Dwindle Layout
bind(mainMod .. " + ALT + V", exec(scriptsDir .. "/ClipManager.sh"))    -- Clipboard Manager
bind(mainMod .. " + CTRL + R", exec(scriptsDir .. "/RofiThemeSelector.sh")) -- KooL Rofi Menu Theme Selector
bind(mainMod .. " + CTRL + SHIFT + R", exec("pkill rofi || true && " .. scriptsDir .. "/RofiThemeSelector-modified.sh")) -- modified Rofi Theme Selector

bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) -- whole full screen
bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))   -- fake full screen
bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))                                -- Float Mode
bind(mainMod .. " + ALT + SPACE", function()                                                           -- All Float Mode
    for _, w in ipairs(hl.get_workspace_windows(hl.get_active_workspace()) or {}) do
        hl.dispatch(hl.dsp.window.float({ action = "toggle", window = "address:" .. w.address }))
    end
end)

-- Dropdown terminal
bind(mainMod .. " + SHIFT + Return", exec(scriptsDir .. "/Dropterminal.sh " .. d.term))

-- Desktop zooming or magnifier
local function zoom(mult)
    return function()
        local factor = hl.get_config("cursor.zoom_factor") or 1
        if factor < 1 then factor = 1 end
        factor = math.max(1, factor * mult)
        hl.config({ cursor = { zoom_factor = factor } })
    end
end
bind(mainMod .. " + ALT + mouse_down", zoom(2.0))
bind(mainMod .. " + ALT + mouse_up", zoom(0.5))

-- Waybar / Bar related
bind(mainMod .. " + CTRL + ALT + B", exec("pkill -SIGUSR1 waybar"))       -- Toggle hide/show waybar
bind(mainMod .. " + CTRL + B", exec(scriptsDir .. "/WaybarStyles.sh"))    -- Waybar Styles Menu
bind(mainMod .. " + ALT + B", exec(scriptsDir .. "/WaybarLayout.sh"))     -- Waybar Layout Menu

-- Night light
bind(mainMod .. " + N", exec(scriptsDir .. "/Hyprsunset.sh toggle"))

-- FEATURES / EXTRAS (UserScripts)
bind(mainMod .. " + SHIFT + M", exec(UserScripts .. "/RofiBeats.sh"))         -- online music using rofi
bind(mainMod .. " + W", exec(UserScripts .. "/WallpaperSelect.sh"))           -- Select wallpaper to apply
bind(mainMod .. " + SHIFT + W", exec(UserScripts .. "/WallpaperEffects.sh"))  -- Wallpaper Effects by imagemagick
bind("CTRL + ALT + W", exec(UserScripts .. "/WallpaperRandom.sh"))           -- Random wallpapers
bind(mainMod .. " + CTRL + O", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" })) -- disable opacity on active window
bind(mainMod .. " + SHIFT + K", exec(scriptsDir .. "/KeyBinds.sh"))           -- search keybinds via rofi
bind(mainMod .. " + SHIFT + A", exec(scriptsDir .. "/Animations.sh"))         -- hyprland animations menu
bind(mainMod .. " + SHIFT + O", exec(UserScripts .. "/ZshChangeTheme.sh"))    -- Change oh-my-zsh theme

-- Keyboard layout switching (release binds, non consuming)
bind("ALT + Shift_L", exec(scriptsDir .. "/SwitchKeyboardLayout.sh"), { release = true, non_consuming = true, locked = true }) -- Change keyboard layout globally
bind("SHIFT + Alt_L", exec(scriptsDir .. "/Tak0-Per-Window-Switch.sh"), { release = true, non_consuming = true, locked = true }) -- Change keyboard layout locally for each window

bind(mainMod .. " + ALT + C", exec(UserScripts .. "/RofiCalc.sh")) -- calculator (qalculate)

-- Move current workspace to a monitor
bind(mainMod .. " + CTRL + F9", hl.dsp.workspace.move({ monitor = "l" }))  -- LEFT monitor
bind(mainMod .. " + CTRL + F10", hl.dsp.workspace.move({ monitor = "r" })) -- RIGHT monitor
bind(mainMod .. " + CTRL + F11", hl.dsp.workspace.move({ monitor = "u" })) -- UP monitor
bind(mainMod .. " + CTRL + F12", hl.dsp.workspace.move({ monitor = "d" })) -- DOWN monitor
