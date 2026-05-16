----------------------------------------------------------
------ ENVIRONMENT VARIABLES ------
----------------------------------------------------------

-- See https://wiki.hyprland.org/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("XDG_MENU_PREFIX", "plasma-")

-- hl.env("XDG_CONFIG_HOME", "$HOME/.config")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("GTK_USE_PORTAL", "1")

hl.env("GDK_BACKEND,wayland,x11", "*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

hl.env("AMD_VULKAN_ICD", "RADV")
