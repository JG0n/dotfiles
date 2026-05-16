--------------------------------------
------ MY PROGRAMS ------
--------------------------------------

-- See https://wiki.hyprland.org/Configuring/Keywords/

-- Set programs that you use
local terminal = "kitty"
local fileManager = "dolphin"

---- Rofi
local menu = "sh $HOME/.config/rofi/bin/launcher"
local runner = "sh $HOME/.config/rofi/bin/runner"
local screenshot = "sh $HOME/.config/rofi/bin/screenshot"
local power = "sh $HOME/.config/rofi/bin/powermenu"

local lock = "hyprlock"

local screenshotWindow = "sh $HOME/.config/hypr/configs/bin/screenshot_window"
local screenshotArea = "sh $HOME/.config/hypr/configs/bin/screenshot_area"
local screenshotMonitor = "sh $HOME/.config/hypr/configs/bin/screenshot_monitor"


--------------------------------------
------ KEYBINDINGS ------
--------------------------------------

-- See https://wiki.hyprland.org/Configuring/Keywords/
MainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Workspaces keybinds (comment out split workspaces if pluggin stops working)
require("configs.keybinds.split-workspace")
-- require("keybinds.workspace")
require("configs.keybinds.focus")
require("configs.keybinds.layout")

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
hl.bind(MainMod .. " + Backspace", hl.dsp.exec_cmd(terminal))
hl.bind(MainMod .. " + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(MainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + DELETE", hl.dsp.exec_cmd(lock))

-- Rofi
hl.bind(MainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(MainMod .. " + R", hl.dsp.exec_cmd(runner))
hl.bind(MainMod .. " + S", hl.dsp.exec_cmd(screenshot))
hl.bind(MainMod .. " + CTRL + S", hl.dsp.exec_cmd(screenshotMonitor))
hl.bind(MainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshotArea))
hl.bind(MainMod .. " + ALT + S", hl.dsp.exec_cmd(screenshotWindow))
hl.bind(MainMod .. " + DELETE", hl.dsp.exec_cmd(power))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(MainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(MainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
