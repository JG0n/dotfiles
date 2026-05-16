require("configs.themes.mocha")

------------------------------------------
------ LOOK AND FEEL ------
------------------------------------------

-- Refer to https://wiki.hyprland.org/Configuring/Variables/

-- https://wiki.hyprland.org/Configuring/Variables/--general
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,

		border_size = 2,

		-- https://wiki.hyprland.org/Configuring/Variables/--variable-types for info about colors
		col = {
			active_border = { colors = { Mauve, Red }, angle = 45 },
			inactive_border = Surface0,
		},

		-- Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
		allow_tearing = true,

		layout = "dwindle",
	},

	ecosystem = {
		enforce_permissions = true
	},

	quirks = {
		prefer_hdr = 2
	},

	-- https://wiki.hyprland.org/Configuring/Variables/--decoration
	decoration = {
		rounding = 10,

		-- Change transparency of focused and unfocused windows
		active_opacity = 0.85,
		inactive_opacity = 0.85,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			-- col.shadow = rgba(1a1a1aee),
		},

		-- https://wiki.hyprland.org/Configuring/Variables/--blur
		blur = {
			enabled = true,
			size = 2,
			passes = 3,


			contrast = 0.8916,
			brightness = 0.45,
			vibrancy = 0.1696,
		},
	},

	-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
	dwindle = {
		-- You probably want this
		preserve_split = true
	},

	-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
	master = {
		new_status = "inherit",
		mfact = 0.70,
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
	scrolling = {
		fullscreen_on_one_column = true,
	},

	-- https://wiki.hyprland.org/Configuring/Variables/--animations
	animations = {
		enabled = true,
	},

	-- https://wiki.hyprland.org/Configuring/Variables/--misc
	misc = {
		-- Set to 0 or 1 to disable the anime mascot wallpapers
		force_default_wallpaper = -1,
		-- If true disables the random hyprland logo / anime girl background. :(
		disable_hyprland_logo = true
	}
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
-- hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
--
-- hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
-- hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
-- hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
-- hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
-- hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
-- hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
-- hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
