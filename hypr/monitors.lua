-- Monitor setup (Lua twin of monitors.conf).
-- See https://wiki.hypr.land/Configuring/Monitors/
-- NOTE: nwg-displays still writes monitors.conf, copy its result here.

-- Any monitor at its highest resolution, auto placed, scale 1.
-- (monitors.conf lists preferred, highrr and highres for the same output; the last one wins.)
-- Use mode = "highrr" instead to prefer the highest refresh rate.
hl.monitor({ output = "", mode = "highres", position = "auto", scale = 1 })
