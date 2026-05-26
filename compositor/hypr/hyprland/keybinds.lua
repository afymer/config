local mainMod      = "SUPER"

-- Apps are launched using uwsm app so they live in separate systemd scope units
-- This prevents the OOM killer from targeting the compositor

local terminal     = "alacritty"
local fileManager  = "nautilus"
local browser      = "zen-browser"
local vscode       = "cursor"
local zed          = "zeditor"
local hyprlock     = "hyprlock"
local colorpicker  = "hyprpicker"
local media_feedback = "bash $HOME/.config/hypr/scripts/media-feedback.sh"
local screenshot   = require("hyprland.screenshot")

local search_cmd   =
    "tofi-drun"
    .. " --font /home/remy/.local/share/fonts/FiraCode/FiraCodeNerdFont-Regular.ttf"
    .. " --hint-font false"
    .. " | xargs uwsm app --"

-- Workspace base offset per monitor.
local monitor_base = {
    ["eDP-1"]    = 1,
    ["HDMI-A-1"] = 1000,
}

local function ws_base()
    local mon = hl.get_active_monitor()
    if mon then
        return monitor_base[mon.name] or 1
    end
    return 1
end

-- Switch to workspace <index> (0-based) on the active monitor
local function ws_switch(i)
    hl.dispatch(hl.dsp.focus({ workspace = ws_base() + i }))
end

-- Move active window to workspace <index> (0-based) on the active monitor
local function ws_move(i)
    hl.dispatch(hl.dsp.window.move({ workspace = ws_base() + i }))
end

hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd(hyprlock))

hl.bind(mainMod .. " + SHIFT + T", function()
    local enabled = hl.get_config("input.touchdevice.enabled")
    hl.config({ input = { touchdevice = { enabled = not enabled } } })
end)

-- HDMI screen
hl.bind(mainMod .. " + P", hl.dsp.focus({ monitor = "HDMI-A-1" }))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.focus({ monitor = "eDP-1" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.move({ workspace = 1000 }))
hl.bind(mainMod .. " + CTRL + SHIFT + P", hl.dsp.window.move({ monitor = "eDP-1" }))

-- Windows
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-- Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ prev = true }))

-- Window resizing
local step        = 20
local step_big    = 80

local resize_opts = { repeating = true }

hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -step, y = 0 }), resize_opts)
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = step, y = 0 }), resize_opts)
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = -step }), resize_opts)
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = step }), resize_opts)

hl.bind(mainMod .. " + ALT + SHIFT + h", hl.dsp.window.resize({ x = -step_big, y = 0 }), resize_opts)
hl.bind(mainMod .. " + ALT + SHIFT + l", hl.dsp.window.resize({ x = step_big, y = 0 }), resize_opts)
hl.bind(mainMod .. " + ALT + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -step_big }), resize_opts)
hl.bind(mainMod .. " + ALT + SHIFT + j", hl.dsp.window.resize({ x = 0, y = step_big }), resize_opts)

hl.bind(mainMod .. " + ALT + left", hl.dsp.window.resize({ x = -step, y = 0 }), resize_opts)
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = step, y = 0 }), resize_opts)
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.resize({ x = 0, y = -step }), resize_opts)
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = step }), resize_opts)

hl.bind(mainMod .. " + ALT + SHIFT + left", hl.dsp.window.resize({ x = -step_big, y = 0 }), resize_opts)
hl.bind(mainMod .. " + ALT + SHIFT + right", hl.dsp.window.resize({ x = step_big, y = 0 }), resize_opts)
hl.bind(mainMod .. " + ALT + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -step_big }), resize_opts)
hl.bind(mainMod .. " + ALT + SHIFT + down", hl.dsp.window.resize({ x = 0, y = step_big }), resize_opts)

-- Resizing windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Special workspaces
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.window.move({ workspace = "+0" }))

hl.bind(mainMod .. " + CTRL + K", hl.dsp.workspace.toggle_special("keepass"))
hl.bind(mainMod .. " + CTRL + O", hl.dsp.workspace.toggle_special("obsidian"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.workspace.toggle_special("beeper"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.workspace.toggle_special("thunderbird"))


local azerty_keys = {
    "ampersand",  -- 0 → ws 1 or 1000
    "eacute",     -- 1 → ws 2 or 1001
    "quotedbl",   -- 2 → ws 3 or 1002
    "apostrophe", -- 3 → ws 4 or 1003
    "parenleft",  -- 4 → ws 5 or 1004
    "minus",      -- 5 → ws 6 or 1005
    "egrave",     -- 6 → ws 7 or 1006
    "underscore", -- 7 → ws 8 or 1007
    "ccedilla",   -- 8 → ws 9 or 1008
    "agrave",     -- 9 → ws 10 or 1009
}

for i, key in ipairs(azerty_keys) do
    local idx = i - 1 -- Dear lua.....

    hl.bind(mainMod .. " + CTRL + " .. key, function()
        ws_switch(idx)
    end)

    hl.bind(mainMod .. " + SHIFT + " .. key, function()
        ws_move(idx)
    end)
end

hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "r-1" }))


-- Apps
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("uwsm app -- " .. vscode))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("uwsm app -- " .. zed))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- " .. browser))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- bluetoothctl"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(search_cmd))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(colorpicker .. " -la"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(
    "[float] " .. terminal .. " -e qalc"
))


-- Misc
hl.bind("SHIFT + PRINT", screenshot.capture_fullscreen_screenshot)
hl.bind("PRINT", screenshot.capture_region_screenshot)
hl.bind("ALT + PRINT", screenshot.capture_window_screenshot)
hl.bind(mainMod .. " + PRINT", screenshot.edit_latest_screenshot)
hl.bind(mainMod .. " + SHIFT + PRINT", screenshot.capture_fullscreen_and_edit_screenshot)

local media_opts = { locked = true, repeating = true }
local locked     = { locked = true }

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(media_feedback .. " volume 5%+"), media_opts)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(media_feedback .. " volume 5%-"), media_opts)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(media_feedback .. " volume mute-toggle"), locked)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(media_feedback .. " brightness 10%+"), media_opts)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(media_feedback .. " brightness 10%-"), media_opts)

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("wpaperctl next-wallpaper"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("makoctl mode -t dnd"))


-- Media
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd("playerctl position 20+"), locked)
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("playerctl previous"), locked)
hl.bind(mainMod .. " + CTRL + SHIFT + H", hl.dsp.exec_cmd("playerctl position 20-"), locked)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
