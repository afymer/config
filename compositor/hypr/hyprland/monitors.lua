hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080",
    position = "auto-up",
    scale    = 1,
})

hl.workspace_rule({ workspace = "r[1-999]", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "r[1000-1100]", monitor = "HDMI-A-1" })
