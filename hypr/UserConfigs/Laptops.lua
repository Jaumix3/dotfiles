-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Keybinds and settings for laptops. Lua twin of Laptops.conf

local v = require("configs.Vars")
local mainMod = v.mainMod
local scriptsDir = v.scriptsDir

local function exec(cmd) return hl.dsp.exec_cmd(cmd) end
local function bind(keys, dsp, opts) return hl.bind(keys, dsp, opts) end

-- for disabling Touchpad. hyprctl devices to get device name.
-- NOTE: scripts/TouchPad.sh reads this name from Laptops.conf, keep both in sync.
local Touchpad_Device = "asue1209:00-04f3:319f-touchpad"

bind("XF86KbdBrightnessDown", exec(scriptsDir .. "/BrightnessKbd.sh --dec"), { repeating = true }) -- decrease keyboard brightness
bind("XF86KbdBrightnessUp", exec(scriptsDir .. "/BrightnessKbd.sh --inc"), { repeating = true })   -- increase keyboard brightness
bind("XF86Launch1", exec("rog-control-center"))                                                    -- ASUS Armory crate button
bind("XF86Launch3", exec("asusctl led-mode -n"))                                                   -- FN+F4 Switch keyboard RGB profile
bind("XF86Launch4", exec("asusctl profile -n"))                                                    -- FN+F5 change of fan profiles
bind("XF86MonBrightnessDown", exec(scriptsDir .. "/Brightness.sh --dec"), { repeating = true })   -- decrease monitor brightness
bind("XF86MonBrightnessUp", exec(scriptsDir .. "/Brightness.sh --inc"), { repeating = true })     -- increase monitor brightness
bind("XF86TouchpadToggle", exec(scriptsDir .. "/TouchPad.sh"))                                    -- disable touchpad

-- Screenshot keybindings for laptops without a Print key
bind(mainMod .. " + F6", exec(scriptsDir .. "/ScreenShot.sh --now"))           -- screenshot
bind(mainMod .. " + SHIFT + F6", exec(scriptsDir .. "/ScreenShot.sh --area"))  -- screenshot (area)
bind(mainMod .. " + CTRL + F6", exec(scriptsDir .. "/ScreenShot.sh --in5"))    -- screenshot (5 secs delay)
bind(mainMod .. " + ALT + F6", exec(scriptsDir .. "/ScreenShot.sh --in10"))    -- screenshot (10 secs delay)
bind("ALT + F6", exec(scriptsDir .. "/ScreenShot.sh --active"))               -- screenshot (active window only)

-- Laptop lid switch (uncomment to disable the internal screen when the lid is closed)
-- bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprctl keyword monitor 'eDP-1, disable'"), { locked = true })
-- bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl keyword monitor 'eDP-1, preferred, auto, 1'"), { locked = true })

hl.device({
    name = Touchpad_Device,
    enabled = true,
})
