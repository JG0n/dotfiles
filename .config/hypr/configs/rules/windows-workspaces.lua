------------------------------------------------------------
------ WINDOWS AND WORKSPACES ------
------------------------------------------------------------

-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
-- See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

-- Example hl.window_rule(v1
-- hl.window_rule(= float, ^(kitty)$

-- Example hl.window_rule(v2
-- windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false
	},

	no_focus = true
})


hl.window_rule({ float = true, match = { class = "(org.kde.plasmawindowed)" } })
-- hl.window_rule(= center, match = { class = "(org.kde.plasmawindowed)" } })
hl.window_rule({ size = "20% 40%", match = { class = "(org.kde.plasmawindowed)" } })

-- Spawn rules

-- Godot
hl.window_rule({ tile = "on", match = { initial_class = "Godot" } })

-- Steam
hl.window_rule({
	name = "steam-client",
	match = { class = "steam" },

	monitor = 0,
	workspace = 2,
})

hl.window_rule({
	name = "steam-apps",
	match = { class = "steam_app_\\d+" },

	monitor = 0,
	workspace = 3,
	fullscreen = true,
})


-- Itch
hl.window_rule({
	name = "itch-client",
	match = { class = "itch" },

	monitor = 0,
	workspace = 4,
})

-- Hypridle
hl.window_rule({
	name = "inhibit-screen-lock",
	idle_inhibit = "fullscreen",

	match = { fullscreen = true }
})
