hl.config({
    general = {
        gaps_in           = 0,
        gaps_out          = 0,
        border_size       = 0,
        no_focus_fallback = true,
        resize_on_border  = false,
        allow_tearing     = false,
        layout            = "master",
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
        disable_autoreload       = true,
        enable_anr_dialog        = false,
    },

    ecosystem = {
        no_update_news = true,
    },

    debug = {
        disable_logs = false,
    },

    decoration = {
        rounding           = 0,
        active_opacity     = 1.0,
        inactive_opacity   = 1.0,
        fullscreen_opacity = 1.0,

        blur               = {
            enabled           = true,
            size              = 14,
            passes            = 2,
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = true,
        },

        shadow             = {
            enabled      = false,
            range        = 15,
            render_power = 5,
            color        = "rgba(0,0,0,.5)",
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
    },

    input = {
        kb_layout      = "fr",
        follow_mouse   = 2,
        sensitivity    = 0,
        force_no_accel = true,
        accel_profile  = "flat",

        touchpad       = {
            natural_scroll = true,
        },

        touchdevice    = {
            enabled = false,
        },
    },
})

-- Kept in case I want to enable it back...
-- hl.curve("fluid", { type = "bezier", points = { { 0.15, 0.85 }, { 0.25, 1 } } })
-- hl.curve("snappy", { type = "bezier", points = { { 0.3, 1 }, { 0.4, 1 } } })

-- hl.animation({ leaf = "windows", enabled = false, speed = 3, bezier = "fluid", style = "popin 5%" })
-- hl.animation({ leaf = "windowsOut", enabled = false, speed = 2.5, bezier = "snappy" })
-- hl.animation({ leaf = "fade", enabled = false, speed = 4, bezier = "snappy" })
-- hl.animation({ leaf = "workspaces", enabled = false, speed = 1.7, bezier = "snappy", style = "slide" })
-- hl.animation({ leaf = "specialWorkspace", enabled = false, speed = 4, bezier = "fluid", style = "slidefadevert -35%" })
-- hl.animation({ leaf = "layers", enabled = false, speed = 2, bezier = "snappy", style = "popin 70%" })

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})
