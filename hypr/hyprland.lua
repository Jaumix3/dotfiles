-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Lua entrypoint for Hyprland 0.55 and newer.
--
-- Hyprland dropped the hyprlang (`hyprland.conf`) format and now only reads
-- `hyprland.lua`. Every `.conf` file in this directory has a `.lua` twin next to
-- it with the same settings, so edit the `.lua` files on current Hyprland.
-- The `.conf` files are kept for older Hyprland versions.
-- https://wiki.hypr.land/

-- Initial boot script to apply initial wallpapers, theming, etc.
-- As long as ~/.config/hypr/.initial_startup_done exists it will not run again.
hl.on("hyprland.start", function()
    hl.exec_cmd("$HOME/.config/hypr/initial-boot.sh")
end)

require("configs.Keybinds")              -- Pre-configured keybinds

-- ## This is where you want to start tinkering
require("UserConfigs.Startup_Apps")      -- Start-up packages
require("UserConfigs.ENVariables")       -- Environment variables
require("UserConfigs.Laptops")           -- Laptop related
require("UserConfigs.LaptopDisplay")     -- Laptop display related
require("UserConfigs.WindowRules")       -- Window rules and layer rules
require("UserConfigs.UserDecorations")   -- Decorations
require("UserConfigs.UserAnimations")    -- Animations
require("UserConfigs.UserKeybinds")      -- Your own keybinds
require("UserConfigs.UserSettings")      -- Main Hyprland settings

-- nwg-displays
require("monitors")
require("workspaces")
