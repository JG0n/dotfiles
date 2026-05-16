hl.window_rule({
	name = "tranparent-windows",
	match = { class = "(kitty|Spotify)" },

	opacity = "0.85",
})

-- hl.window_rule({
-- 	match = { class = "Spotify"},
--
-- 	opacity = "0.85",
-- })

hl.window_rule({
	name = "force-opaque-windows",
	match = { class = "app.zen_browser.zen" },

	opacity = "1.0 override",
})
