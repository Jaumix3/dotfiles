-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Main Hyprland settings. Lua twin of UserSettings.conf
-- See https://wiki.hypr.land/Configuring/Variables/

hl.config({
    dwindle = {
        preserve_split = true,
        special_scale_factor = 0.8,
    },

    master = {
        new_status = "master",
        new_on_top = true,
        mfact = 0.5,
    },

    general = {
        resize_on_border = true,
        layout = "dwindle",
    },

    input = {
        kb_layout = "es",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        repeat_rate = 50,
        repeat_delay = 300,

        sensitivity = 0, -- mouse sensitivity
        numlock_by_default = true,
        left_handed = false,
        follow_mouse = 1,
        float_switch_override_focus = false,

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            clickfinger_behavior = false,
            middle_button_emulation = false,
            tap_to_click = true,
            drag_lock = false,
        },

        touchdevice = {
            enabled = true,
        },

        tablet = {
            transform = 0,
            left_handed = false,
        },
    },

    gestures = {
        workspace_swipe_distance = 500,
        workspace_swipe_invert = true,
        workspace_swipe_min_speed_to_force = 30,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_create_new = true,
        workspace_swipe_forever = true,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 2,
        mouse_move_enables_dpms = true,
        enable_swallow = false,
        swallow_regex = "^(kitty)$",
        focus_on_activate = false,
        initial_workspace_tracking = 0,
        middle_click_paste = false,
        enable_anr_dialog = true,         -- Application not Responding (ANR)
        anr_missed_pings = 15,            -- ANR Threshold default 1 is too low
        allow_session_lock_restore = true, -- Prevent lockscreen crash when resume from suspend
    },

    -- variable frame rate (misc.vfr moved to debug.vfr, on by default)
    debug = {
        vfr = true,
    },

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },

    -- Could help when scaling and not pixelating
    xwayland = {
        enabled = true,
        force_zero_scaling = true,
    },

    -- render section for Hyprland >= v0.42.0
    render = {
        direct_scanout = 0,
    },

    cursor = {
        sync_gsettings_theme = true,
        no_hardware_cursors = 2, -- change to 1 if want to disable
        enable_hyprcursor = true,
        warp_on_change_workspace = 2,
        no_warps = true,
    },
})

-- 3 finger horizontal swipe to change workspace
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
