-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Decorations. Lua twin of UserDecorations.conf
-- Colors come from wallust (~/.config/hypr/wallust/wallust-hyprland.conf), which
-- scripts/WallustSwww.sh regenerates on every wallpaper change.

local v = require("configs.Vars")

-- Parse `$colorN = rgb(XXXXXX)` lines written by wallust.
local colors = {}
local f = io.open(v.hypr .. "/wallust/wallust-hyprland.conf", "r")
if f then
    for line in f:lines() do
        local name, value = line:match("^%s*%$([%w_]+)%s*=%s*(%S+)")
        if name then colors[name] = value end
    end
    f:close()
end
local function c(name, fallback) return colors[name] or fallback end

hl.config({
    general = {
        border_size = 2,
        gaps_in = 2,
        gaps_out = 4,
        col = {
            active_border = c("color12", "rgb(6D6669)"),
            inactive_border = c("color10", "rgb(363033)"),
        },
    },

    decoration = {
        rounding = 10,

        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        dim_inactive = true,
        dim_strength = 0.1,
        dim_special = 0.8,

        shadow = {
            enabled = true,
            range = 3,
            render_power = 1,
            color = c("color12", "rgb(6D6669)"),
            color_inactive = c("color10", "rgb(363033)"),
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            ignore_opacity = true,
            new_optimizations = true,
            special = true,
            popups = true,
        },
    },

    group = {
        col = {
            border_active = c("color15", "rgb(DBD8DA)"),
        },
        groupbar = {
            col = {
                active = c("color0", "rgb(525152)"),
            },
        },
    },
})
