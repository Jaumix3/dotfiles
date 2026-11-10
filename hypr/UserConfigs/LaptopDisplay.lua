-- NOTE: Lua twin of LaptopDisplay.conf (used to disable the laptop display when closing the lid).
-- See notes on Laptops.lua

-- hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "0x0", scale = 1 })
hl.monitor({ output = "DVI-D-1", mode = "1366x768", position = "1920x0", scale = 1 })
