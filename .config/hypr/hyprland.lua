-- Permissions
require("configs.permissions")


----------------------------------
------ AUTOSTART ------
----------------------------------

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

-- hl.exec_cmd("$terminal")
-- hl.exec_cmd("nm-applet &")
-- hl.exec_cmd("waybar & hyprpaper & firefox")

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("[workspace 20 silent] discord")
	-- hl.exec_cmd("[workspace 10 silent] steam-runtime")
	--hl.exec_cmd("[workspace 1 silent] firefox")
	hl.exec_cmd("waybar & hyprpaper & kbuildsycoca6 & swaync")
	hl.exec_cmd("hypridle >> ~/hypridle.log")
end)

hl.on("config.reloaded", function()
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme \"breeze-gtk\"")  -- for GTK3 apps
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"") -- for GTK4 apps
end)


-- Monitors
require("configs.monitors")
-- Keybinds
require("configs.keybindings")
-- Window rules
require("configs.rules")
-- Input Devices
require("configs.input")
-- Enviormental variables
require("configs.env")
-- Theme
require("configs.themes.theme")
-- Plugins
require("configs.split-workspaces")
