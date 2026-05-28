hl.layer_rule({
    name    = "no-anim-hyprpicker",
    match   = { namespace = "hyprpicker" },
    no_anim = true,
})

hl.layer_rule({
    name    = "no-anim-selection",
    match   = { namespace = "selection" },
    no_anim = true,
})

-- KeePass
hl.window_rule({
    name      = "keep-keepass-away",
    match     = { class = "KeePassXC" },
    workspace = "special:keepass",
})

-- Beeper
hl.window_rule({
    name      = "keep-beeper-away",
    match     = { class = "beepertexts" },
    workspace = "special:beeper",
})

-- Thunderbird
hl.window_rule({
    name      = "keep-thunderbird-away",
    match     = { class = "org.mozilla.Thunderbird" },
    workspace = "special:thunderbird",
})

-- Obsidian
hl.window_rule({
    name      = "keep-obsidian-away",
    match     = { class = "obsidian" },
    workspace = "special:obsidian",
})

-- Zen
hl.window_rule({
    name      = "keep-zen-away",
    match     = { class = "zen" },
    workspace = "special:zen",
})

