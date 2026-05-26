local M = {}

local screenshot_dir          = os.getenv("HOME") .. "/hdata/pictures/screenshots"
local latest_screenshot       = screenshot_dir .. "/latest.png"
local latest_screenshot_meta  = screenshot_dir .. "/latest.meta"
local edited_screenshot_glob  = screenshot_dir .. "/%Y%m%d_%H%M%S_edit.png"
local screenshot_dir_shell    = "$HOME/hdata/pictures/screenshots"
local satty_min_width         = 320
local satty_min_height        = 240

local function notify(text)
    hl.notification.create({ text = text, duration = 2500 })
end

local function sh_quote(value)
    return "'" .. tostring(value):gsub("'", [['"'"']]) .. "'"
end

local function read_latest_screenshot_meta()
    local file = io.open(latest_screenshot_meta, "r")
    if not file then
        return {}
    end

    local meta = {}
    for line in file:lines() do
        local key, value = line:match("^([%w_]+)=(.*)$")
        if key then
            meta[key] = value
        end
    end
    file:close()
    return meta
end

local function parse_slurp_geometry(geometry)
    local x, y, w, h = geometry:match("^(%-?%d+),(%-?%d+)%s+(%d+)x(%d+)$")
    if not x then
        return nil
    end

    return {
        x = tonumber(x),
        y = tonumber(y),
        w = tonumber(w),
        h = tonumber(h),
    }
end

local function clamp_satty_geometry(geometry)
    return {
        x = geometry.x,
        y = geometry.y,
        w = math.max(geometry.w, satty_min_width),
        h = math.max(geometry.h, satty_min_height),
    }
end

local function active_monitor_geometry()
    local mon = hl.get_active_monitor()
    if not mon then
        return nil
    end

    local x = mon.x or (mon.position and mon.position.x)
    local y = mon.y or (mon.position and mon.position.y)
    local w = mon.width or (mon.size and mon.size.x)
    local h = mon.height or (mon.size and mon.size.y)

    if not (x and y and w and h) then
        return nil
    end

    return {
        x = x,
        y = y,
        w = w,
        h = h,
    }
end

local function fullscreen_satty_rules()
    local monitor_geometry = active_monitor_geometry()
    if not monitor_geometry then
        return { float = true }
    end

    return {
        float = true,
        move = { monitor_geometry.x, monitor_geometry.y },
        size = { monitor_geometry.w, monitor_geometry.h },
    }
end

local function satty_edit_command(filename)
    return "satty -f " .. sh_quote(filename)
        .. " --copy-command wl-copy -o " .. sh_quote(edited_screenshot_glob)
end

local function satty_edit_command_shell(filename_expr)
    return "satty -f " .. filename_expr
        .. " --copy-command wl-copy -o " .. sh_quote(edited_screenshot_glob)
end

local function next_screenshot_path_shell()
    return screenshot_dir_shell .. '/$(date +%Y%m%d_%H%M%S).png'
end

local function fullscreen_capture_command()
    return table.concat({
        "mkdir -p " .. sh_quote(screenshot_dir) .. " || exit 1",
        'f="' .. next_screenshot_path_shell() .. '"',
        'grim "$f"',
        'wl-copy < "$f"',
        'ln -sfn "$f" ' .. sh_quote(latest_screenshot),
        'printf "mode=fullscreen\n" > ' .. sh_quote(latest_screenshot_meta),
    }, "; ")
end

local function selection_capture_command(mode, geometry_command)
    return table.concat({
        "mkdir -p " .. sh_quote(screenshot_dir) .. " || exit 1",
        'g="$(' .. geometry_command .. ')"',
        '[ -n "$g" ] || exit 0',
        'f="' .. next_screenshot_path_shell() .. '"',
        'grim -g "$g" "$f"',
        'wl-copy < "$f"',
        'ln -sfn "$f" ' .. sh_quote(latest_screenshot),
        'printf "mode=' .. mode .. '\\ngeometry=%s\\n" "$g" > ' .. sh_quote(latest_screenshot_meta),
    }, "; ")
end

local function region_capture_command()
    return selection_capture_command("region", "slurp")
end

local function window_capture_command()
    return selection_capture_command(
        "window",
        [[hyprctl monitors -j | jq -r 'map(select(.focused == true)) | first | [.id, .activeWorkspace.id] | @tsv' | { read -r mon ws && [ -n "$mon" ] && [ -n "$ws" ] && hyprctl clients -j | jq -r --argjson mon "$mon" --argjson ws "$ws" '.[] | select(.mapped == true and .hidden == false and .monitor == $mon and (.workspace.id == $ws or .pinned == true)) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'; } | slurp]]
    )
end

function M.capture_fullscreen_screenshot()
    hl.exec_cmd(fullscreen_capture_command())
end

function M.capture_region_screenshot()
    hl.exec_cmd(region_capture_command())
end

function M.capture_window_screenshot()
    hl.exec_cmd(window_capture_command())
end

function M.capture_fullscreen_and_edit_screenshot()
    local cmd = table.concat({
        "mkdir -p " .. sh_quote(screenshot_dir) .. " || exit 1",
        'f="' .. next_screenshot_path_shell() .. '"',
        'grim "$f"',
        'wl-copy < "$f"',
        'ln -sfn "$f" ' .. sh_quote(latest_screenshot),
        'printf "mode=fullscreen\n" > ' .. sh_quote(latest_screenshot_meta),
        "exec " .. satty_edit_command_shell([["$f"]]),
    }, "; ")

    hl.exec_cmd(cmd, fullscreen_satty_rules())
end

function M.edit_latest_screenshot()
    local file = io.open(latest_screenshot, "rb")
    if not file then
        notify("No screenshot to edit")
        return
    end
    file:close()

    local cmd = satty_edit_command(latest_screenshot)

    local meta = read_latest_screenshot_meta()
    if meta.mode == "fullscreen" then
        hl.exec_cmd(cmd, fullscreen_satty_rules())
        return
    end

    local geometry = meta.geometry and parse_slurp_geometry(meta.geometry)
    if geometry then
        local window_geometry = clamp_satty_geometry(geometry)
        hl.exec_cmd(cmd, {
            float = true,
            move = { window_geometry.x, window_geometry.y },
            size = { window_geometry.w, window_geometry.h },
        })
        return
    end

    hl.exec_cmd(cmd, { float = true })
end

return M
