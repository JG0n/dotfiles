-- Move focus with mainMod + arrow keys
hl.bind(MainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(MainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(MainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(MainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(MainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(MainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(MainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(MainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(MainMod .. " + TAB", hl.dsp.window.cycle_next({ next = 1 }))
-- bind = $MainMod, TAB, cyclenext, visible prev
-- bind = $MainMod SHIFT, TAB, cyclenext, visible

-- Move windows
hl.bind("ALT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("ALT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("ALT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("ALT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("ALT + down", hl.dsp.window.move({ direction = "d" }))

hl.bind("ALT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("ALT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind("ALT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("ALT + J", hl.dsp.window.move({ direction = "d" }))

hl.bind("ALT + TAB", hl.dsp.window.move({ direction = "r" }))
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.move({ direction = "l" }))
