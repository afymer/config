hl.on("hyprland.start", function()
    -- Daemons
    hl.exec_cmd("uwsm-app -- hypridle")
    hl.exec_cmd("uwsm-app -- wpaperd -d")
    hl.exec_cmd("uwsm-app -- hyprsunset")

    -- Clipboard history
    hl.exec_cmd("uwsm-app -- wl-paste --type text  --watch cliphist store")
    hl.exec_cmd("uwsm-app -- wl-paste --type image --watch cliphist store")

    -- Misc
    hl.exec_cmd("uwsm-app -- mako")
    hl.exec_cmd("uwsm-app -- waybar")
    hl.exec_cmd("uwsm-app -- hyprosd")

    -- Fixed using a systemd unit, kept just in case...
    -- hl.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0")

    -- Special workspaces
    hl.exec_cmd("uwsm-app -- keepassxc")
    -- hl.exec_cmd("uwsm-app -- obsidian")
    -- hl.exec_cmd("uwsm-app -- thunderbird")
end)

-- Re-apply on every config reload so it survives restarts.
local function apply_gtk_dark()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
end

hl.on("hyprland.start", apply_gtk_dark)
hl.on("config.reloaded", apply_gtk_dark)
