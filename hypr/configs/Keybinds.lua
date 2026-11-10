-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Default keybinds. Lua twin of Keybinds.conf
-- To add your own, use UserConfigs/UserKeybinds.lua instead.
-- To remove a bind defined here, call hl.unbind("<keys>") in UserKeybinds.lua.

local v = require("configs.Vars")
local mainMod = v.mainMod
local scriptsDir = v.scriptsDir

local function exec(cmd) return hl.dsp.exec_cmd(cmd) end
local function bind(keys, dsp, opts) return hl.bind(keys, dsp, opts) end

-- common shortcuts
bind("CTRL + ALT + Delete", hl.dsp.exit())                                 -- exit Hyprland
bind(mainMod .. " + Q", hl.dsp.window.close())                             -- close active (not kill)
bind(mainMod .. " + SHIFT + Q", exec(scriptsDir .. "/KillActiveProcess.sh")) -- Kill active process
bind("CTRL + ALT + L", exec(scriptsDir .. "/LockScreen.sh"))               -- screen lock
bind("CTRL + ALT + P", exec(scriptsDir .. "/Wlogout.sh"))                  -- power menu
bind(mainMod .. " + SHIFT + N", exec("swaync-client -t -sw"))              -- swayNC notification panel
bind(mainMod .. " + SHIFT + E", exec(scriptsDir .. "/Kool_Quick_Settings.sh")) -- KooL Hyprland Settings menu

-- Master Layout
bind(mainMod .. " + CTRL + D", hl.dsp.layout("removemaster"))
bind(mainMod .. " + I", hl.dsp.layout("addmaster"))
bind(mainMod .. " + J", hl.dsp.layout("cyclenext"))
bind(mainMod .. " + K", hl.dsp.layout("cycleprev"))
bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster"))

-- Dwindle Layout
bind(mainMod .. " + SHIFT + I", hl.dsp.layout("togglesplit"))  -- only works on dwindle layout
bind(mainMod .. " + P", hl.dsp.window.pseudo())                -- dwindle
bind(mainMod .. " + M", hl.dsp.layout("splitratio 0.3"))

-- Works on either layout (Master or Dwindle)
bind(mainMod .. " + G", hl.dsp.group.toggle())                 -- toggle group
bind(mainMod .. " + CTRL + Tab", hl.dsp.group.next())          -- change focus to another window in the group

-- Cycle windows if floating bring to top
bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next({ next = true }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Special Keys / Hot keys
bind("XF86AudioRaiseVolume", exec(scriptsDir .. "/Volume.sh --inc"), { locked = true, repeating = true }) -- volume up
bind("XF86AudioLowerVolume", exec(scriptsDir .. "/Volume.sh --dec"), { locked = true, repeating = true }) -- volume down
bind("XF86AudioMicMute", exec(scriptsDir .. "/Volume.sh --toggle-mic"), { locked = true })              -- mic mute
bind("XF86AudioMute", exec(scriptsDir .. "/Volume.sh --toggle"), { locked = true })                     -- mute
bind("XF86Sleep", exec("systemctl suspend"), { locked = true })                                        -- sleep button
bind("XF86Rfkill", exec(scriptsDir .. "/AirplaneMode.sh"), { locked = true })                          -- Airplane mode

-- media controls using keyboards
bind("XF86AudioPause", exec(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
bind("XF86AudioPlay", exec(scriptsDir .. "/MediaCtrl.sh --pause"), { locked = true })
bind("XF86AudioNext", exec(scriptsDir .. "/MediaCtrl.sh --nxt"), { locked = true })
bind("XF86AudioPrev", exec(scriptsDir .. "/MediaCtrl.sh --prv"), { locked = true })
bind("XF86AudioStop", exec(scriptsDir .. "/MediaCtrl.sh --stop"), { locked = true })

-- Screenshot keybindings NOTE: You may need to press Fn key as well
bind(mainMod .. " + Print", exec(scriptsDir .. "/ScreenShot.sh --now"))                    -- screenshot
bind(mainMod .. " + SHIFT + Print", exec(scriptsDir .. "/ScreenShot.sh --area"))           -- screenshot (area)
bind(mainMod .. " + CTRL + Print", exec(scriptsDir .. "/ScreenShot.sh --in5"))             -- screenshot (5 secs delay)
bind(mainMod .. " + CTRL + SHIFT + Print", exec(scriptsDir .. "/ScreenShot.sh --in10"))    -- screenshot (10 secs delay)
bind("ALT + Print", exec(scriptsDir .. "/ScreenShot.sh --active"))                        -- screenshot (active window only)

-- screenshot with swappy (another screenshot tool)
bind(mainMod .. " + SHIFT + S", exec(scriptsDir .. "/ScreenShot.sh --swappy"))

-- Resize windows
bind(mainMod .. " + SHIFT + Left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
bind(mainMod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
bind(mainMod .. " + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
bind(mainMod .. " + SHIFT + Down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Move windows
bind(mainMod .. " + CTRL + Left", hl.dsp.window.move({ direction = "l" }))
bind(mainMod .. " + CTRL + Right", hl.dsp.window.move({ direction = "r" }))
bind(mainMod .. " + CTRL + Up", hl.dsp.window.move({ direction = "u" }))
bind(mainMod .. " + CTRL + Down", hl.dsp.window.move({ direction = "d" }))

-- Swap windows
bind(mainMod .. " + ALT + Left", hl.dsp.window.swap({ direction = "l" }))
bind(mainMod .. " + ALT + Right", hl.dsp.window.swap({ direction = "r" }))
bind(mainMod .. " + ALT + Up", hl.dsp.window.swap({ direction = "u" }))
bind(mainMod .. " + ALT + Down", hl.dsp.window.swap({ direction = "d" }))

-- Move focus with mainMod + arrow keys
bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }))
bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }))
bind(mainMod .. " + Down", hl.dsp.focus({ direction = "down" }))

-- Workspaces related
bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "m+1" }))
bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))

-- Special workspace
bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }))
bind(mainMod .. " + U", hl.dsp.workspace.toggle_special(""))

-- Switch workspaces / move windows with mainMod + [0-9]
-- NOTE: code:10 = key 1 ... code:19 = key 0 (works on any keyboard layout)
for i = 1, 10 do
    local key = "code:" .. (9 + i)
    bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = "-1" }))  -- brackets [
bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1" })) -- brackets ]
bind(mainMod .. " + CTRL + bracketleft", hl.dsp.window.move({ workspace = "-1", follow = false }))
bind(mainMod .. " + CTRL + bracketright", hl.dsp.window.move({ workspace = "+1", follow = false }))

-- Scroll through existing workspaces with mainMod + scroll
bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })   -- left click
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- right click
