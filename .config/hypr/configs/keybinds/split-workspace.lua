-- keybinds.lua
local smw = hl.plugin.split_monitor_workspaces

-- Switch workspaces with MainMod + [1-5]
for i = 1, 9 do
	local key = tostring(i)
	hl.bind(MainMod .. " + " .. key, function() return smw.workspace(i) end)
	hl.bind(MainMod .. " + SHIFT + " .. key, function() return smw.move_to_workspace(i) end)
end

hl.bind(MainMod .. " + 0", function() return smw.workspace(10) end)

-- Scroll through existing workspaces with MainMod + scroll
hl.bind(MainMod .. " + mouse_down", function() return smw.workspace("e+1") end)
hl.bind(MainMod .. " + mouse_up", function() return smw.workspace("e-1") end)
hl.bind(MainMod .. " + CONTROL + h", function() return smw.workspace("e-1") end)
hl.bind(MainMod .. " + CONTROL + l", function() return smw.workspace("e+1") end)
hl.bind(MainMod .. " + CONTROL + k", function() return smw.workspace("r+1") end)
hl.bind(MainMod .. " + CONTROL + j", function() return smw.workspace("r-1") end)
hl.bind(MainMod .. " + page_up", function() return smw.workspace("e+1") end)
hl.bind(MainMod .. " + page_down", function() return smw.workspace("e-1") end)
hl.bind(MainMod .. " + CONTROL + page_up", function() return smw.workspace("+1") end)
hl.bind(MainMod .. " + CONTROL + page_down", function() return smw.workspace("-1") end)

hl.bind(MainMod .. " + SHIFT + page_up", function() return smw.move_to_workspace("page_up") end)
hl.bind(MainMod .. " + SHIFT + page_down", function() return smw.move_to_workspace("page_down") end)
hl.bind(MainMod .. " + SHIFT + h", function() return smw.move_to_workspace("h") end)
hl.bind(MainMod .. " + SHIFT + l", function() return smw.move_to_workspace("l") end)
hl.bind(MainMod .. " + SHIFT + k", function() return smw.move_to_workspace("k") end)
hl.bind(MainMod .. " + SHIFT + j", function() return smw.move_to_workspace("j") end)
