-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  --
-- Environment variables. See https://wiki.hypr.land/Configuring/Environment-variables/
-- Lua twin of ENVariables.conf (see that file for more commented-out NVIDIA / debug options)

-- Set your defaults editor through ENV in ~/.config/hypr/UserConfigs/01-UserDefaults.lua

-- environment-variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("CLUTTER_BACKEND", "wayland")

-- xdg Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- QT Variables
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style")

-- hyprland-qt-support
-- (QT_QUICK_CONTROLS_STYLE above)

-- xwayland apps scale fix (useful if you are use monitor scaling)
-- see https://wiki.hypr.land/Configuring/XWayland/
hl.env("GDK_SCALE", "1")
hl.env("QT_SCALE_FACTOR", "1")

-- Bibata-Modern-Ice (hyprcursor)
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-- firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- electron >28 apps (may help)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto") -- auto selects Wayland if possible, X11 otherwise

-- NVIDIA (uncomment if you use an NVIDIA GPU)
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("NVD_BACKEND", "direct")
-- hl.env("GBM_BACKEND", "nvidia-drm")
