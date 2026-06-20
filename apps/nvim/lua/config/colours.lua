local c = {
        red = { '#e06c75', 'r' },
        green = { '#98c379', 'g' },
        rust = { '#a52a2a', 'u' },
        cyan = { '#77bbcc', 'c' },
        grey = { '#5c6350', 'e' },
        darkgrey = { '#4c3330', 'e' },
        yellow = { '#e5c07b', 'y' },
        magenta = { '#c678dd', 'm' },
        orange = { '#ff9955', 'o' },
        purple = { '#553355', 'p' },
        brown = { '#442200', 'n' },
        semidark = { '#4b5263', 'sd' },
        darkblue = { '#003366', 'db' },
        darkgreen = { '#114411', 'dg' },
        darkred = { '#662222', 'dr' },
        lightred = { '#f28a92', 'lr' },
        darkmagenta = { '#660066', 'dm' },
        darkcyan = { '#558899', 'dc' },
        dark = { '#222211', 'd' },
        white = { '#ffffd0', 'w' },
        black = { '#000000', 'b' },
        truegreen = { '#66cc33', 'tg' },
        truered = { '#ff6600', 'tr' },
}

local function fix_colour(colour)
        if type(colour) == 'table' then
                return colour[1]
        else
                return colour
        end
end

local function h(fg, bg, opts)
        return {
                fg = fix_colour(fg),
                bg = fix_colour(bg),
                bold = opts and opts.b,
                italic = opts and opts.i,
                strikethrough = opts and opts.s,
                priority = opts and opts.p,
                underline = opts and opts.u,
        }
end

vim.api.nvim_command('highlight clear')

local none = h('#ff0000')

local b = { b = true }
local i = { i = true }
local s = { s = true }
local u = { u = true }

local title = h(c.magenta, c.black, b)

local colours = {

        --------------
        --- Window ---
        --------------
        CursorLineNr = h(c.red),
        CursorLine = h(nil, c.dark),
        StatusLine = h(nil, c.black),
        StatusLineNC = h(nil, c.black),
        Directory = h(c.red),
        -- 	TabLine = h(nil, c.red),
        -- 	TabLineSel = h(nil, c.green),
        -- 	TabLineFill = h(nil, c.yellow),
        NormalFloat = h(c.green, c.black), -- registers, trouble, buf.hover, g?, etc.
        WinSeparator = h(c.dark, c.dark), -- separator between buffers and borders around floating buffers
        FloatBorder = h(c.magenta),

        --------------
        --- Editor ---
        --------------

        Normal = h(c.white, c.black),
        Search = h(nil, c.grey),
        IncSearch = h(c.yellow, c.darkred),
        CurSearch = h(c.black, c.lightred),

        --------------
        --- Syntax ---
        --------------
        Include = h(c.magenta),
        cIncluded = h(c.magenta),
        String = h(c.yellow),
        Folded = h(c.green),
        CustomSuccess = h(c.green),
        CustomIgnored = h(c.darkcyan),
        CustomWarning = h(c.yellow),
        CustomError = h(c.red),
        Title = h(c.magenta),
        Statement = h(c.red),
        JiraBold = h(c.green, nil, b),
        JiraItalic = h(c.cyan, nil, i),

        --> cf. https://neovim.io/doc/user/treesitter.html#treesitter-highlight-groups

        --- Vars ---
        ['@variable'] = h(c.cyan), -- idents
        ['@variable.builtin'] = h(c.darkcyan), -- this, self
        ['@variable.parameter'] = h(c.cyan), -- params of functions, objects
        ['@variable.parameter.builtin'] = h(c.darkcyan), -- special parameters (e.g. _, it, ..., this)
        ['@variable.member'] = h(c.darkcyan), -- object and struct fields

        --- Consts ---
        ['@constant'] = h(c.darkcyan), -- const idents
        ['@constant.builtin'] = h(c.darkcyan), -- built-in constant values
        ['@constant.macro'] = h(c.orange), -- constants defined by the preprocessor

        --- Mods ---
        ['@module'] = h(c.orange), -- modules or namespaces
        ['@module.builtin'] = h(c.red), -- built-in modules or namespaces

        --- Labels ---
        ['@label'] = h(c.orange), -- C labels, Rust labels

        --- Strs ---
        ['@string'] = h(c.yellow),
        ['@string.documentation'] = h(c.grey), -- docstrings
        ['@string.regexp'] = h(c.orange), -- regular expressions
        ['@string.escape'] = h(c.orange), -- escape sequences
        ['@string.special'] = h(c.orange), -- other special strings (e.g. dates)
        ['@string.special.symbol'] = h(c.darkcyan), -- symbols or atoms (e.g., Makefile variables)
        ['@string.special.path'] = h(c.yellow), -- filename, e.g. in git commit files
        ['@string.special.url'] = h(c.orange), -- URIs (e.g. hyperlinks)
        ['@string.special.vimdoc'] = h(c.red), -- <thing> in vimdoc
        ['@character'] = h(c.green), -- character literals
        ['@character.special'] = h(c.orange), -- special characters (e.g. wildcards)

        --- Lits ---
        ['@boolean'] = h(c.orange), -- boolean literals
        ['@number'] = h(c.magenta), -- numeric literals
        ['@number.float'] = h(c.magenta), -- floating-point number literals

        --- Types ---
        ['@type'] = h(c.darkcyan), -- type or class definitions and annotations
        ['@type.builtin'] = h(c.darkcyan), -- built-in types
        ['@type.definition'] = h(c.darkcyan), -- identifiers in type definitions (e.g. typedef <type> <identifier> in C)
        ['@attribute'] = h(c.magenta), -- attribute annotations (e.g. Python decorators, Rust lifetimes)
        ['@attribute.builtin'] = h(c.magenta), -- builtin annotations (e.g. @property in Python)
        ['@property'] = h(c.cyan), -- the key in key/value pairs

        --         ["@constructor"] = h(c.red), !! already red by default :omg:

        --- Fns ---
        ['@function'] = h(c.green), -- function definitions
        ['@function.builtin'] = h(c.green), -- built-in functions
        ['@function.call'] = h(c.green), -- function calls
        ['@function.macro'] = h(c.magenta), -- C: macro def, Rust: macro call
        ['@function.method'] = h(c.green), -- method definitions
        ['@function.method.call'] = h(c.green), -- method calls, Python but not Rust
        ['@constructor'] = h(c.orange), -- constructor calls and definitions (__new__)
        ['@operator'] = h(c.magenta), -- symbolic operators (e.g. +, *)

        --- Keywds ---
        ['@keyword'] = h(c.red), -- keywords not fitting into specific categories
        ['@keyword.coroutine'] = h(c.red), -- keywords related to coroutines (e.g. go in Go, async/await in Python)
        ['@keyword.function'] = h(c.red), -- keywords that define a function (e.g. func in Go, def in Python)
        ['@keyword.operator'] = h(c.red), -- operators that are English words (e.g. and, or)
        ['@keyword.import'] = h(c.magenta), -- keywords for including or exporting modules (e.g. import, from in Python)
        ['@keyword.type'] = h(c.red), -- keywords describing namespaces and composite types (e.g. struct, enum)
        ['@keyword.modifier'] = h(c.red), -- keywords modifying none constructs (e.g. const, static, public)
        ['@keyword.repeat'] = h(c.red), -- keywords related to loops (e.g. for, while)
        ['@keyword.return'] = h(c.red), -- keywords like return and yield
        ['@keyword.debug'] = h(c.red), -- keywords related to debugging
        ['@keyword.exception'] = h(c.red), -- keywords related to exceptions (e.g. throw, catch)
        ['@keyword.conditional'] = h(c.red), -- keywords related to conditionals (e.g. if, else)
        ['@keyword.conditional.ternary'] = h(c.red), -- ternary operator (e.g. ?, :)
        ['@keyword.directive'] = h(c.red), -- various preprocessor directives and shebangs
        ['@keyword.directive.define'] = h(c.red), -- preprocessor definition directives

        --- Puncs ---
        ['@punctuation.delimiter'] = h(c.magenta), -- delimiters (e.g. ;, ., ,)
        ['@punctuation.bracket'] = h(c.magenta), -- brackets (e.g. (), {}, [])
        ['@punctuation.special'] = h(c.magenta), -- special symbols (e.g. {} in string interpolation)

        --- Comments ---
        ['@comment'] = h(c.grey), -- line and block comments
        ['@comment.documentation'] = h(c.grey), -- comments documenting code
        ['@comment.error'] = h(c.red), -- error-type comments (e.g. ERROR, FIXME, DEPRECATED)
        ['@comment.warning'] = h(c.yellow), -- warning-type comments (e.g. WARNING, FIX, HACK)
        ['@comment.todo'] = h(c.darkblue), -- todo-type comments (e.g. TODO, WIP)
        ['@comment.note'] = h(c.green), -- note-type comments (e.g. NOTE, INFO, XXX)

        --- Markup ---
        ['@markup.strong'] = h(c.orange, nil, b), -- bold text
        ['@markup.italic'] = h(c.cyan, nil, i), -- italic text
        ['@markup.strikethrough'] = h(c.yellow, nil, s), -- struck-through text
        ['@markup.underline'] = h(nil, nil, u), -- underlined text (only for literal underline markup!)
        ['@markup.heading'] = title, -- headings, titles (including markers)
        -- ["@markup.heading.1"] = title, -- top-level heading
        --["@markup.heading.2"] = none, -- section heading
        --["@markup.heading.3"] = none, -- subsection heading
        --["@markup.heading.4"] = none, -- and so on
        --["@markup.heading.5"] = none, -- and so forth
        --["@markup.heading.6"] = none, -- six levels ought to be enough for anybody
        ['@markup.quote'] = h(c.green), -- block quotes
        -- ["@markup.math"] = none, -- math environments (e.g. $ ... $ in LaTeX)
        ['@markup.link'] = h(c.orange), -- text references, footnotes, citations, etc.
        ['@markup.link.label'] = h(c.yellow), -- link, reference descriptions
        ['@markup.link.url'] = h(c.cyan), -- URL-style links
        --["@markup.raw"] = none, -- literal or verbatim text (e.g. inline code)
        --["@markup.raw.block"] = none, -- literal or verbatim text as a stand-alone block
        ['@markup.list'] = title, -- list markers
        --["@markup.list.checked"] = none, -- checked todo-style list markers
        --["@markup.list.unchecked"] = none, -- unchecked todo-style list markers

        --- Diff ---
        ['@diff.plus'] = h(c.green), -- added text (for diff files)
        ['@diff.minus'] = h(c.red), -- deleted text (for diff files)
        ['@diff.delta'] = h(c.yellow), -- changed text (for diff files)

        DiffAdd = h(nil, '#002200'),
        DiffDelete = h(c.red, '#330000'),
        DiffChange = h(nil, '#332200'),
        DiffText = h(nil, '#551144'),

        --- Tags ---
        ['@tag'] = h(c.cyan), -- XML-style tag names (e.g. in XML, HTML, etc.)
        ['@tag.builtin'] = h(c.cyan), -- builtin tag names (e.g. HTML5 tags)
        ['@tag.attribute'] = h(c.darkcyan), -- XML-style tag attributes
        ['@tag.delimiter'] = h(c.magenta), -- XML-style tag delimiters

        --- LSP ---
        ['@lsp.type.enumMember.rust'] = h(c.cyan),

        ------------------
        ---- Git Signs ---
        ------------------
        GitSignsAdd = h(c.truegreen),
        GitSignsChange = h(c.yellow),
        GitSignsDelete = h(c.truered),

        -----------
        --- Oil ---
        -----------
        OilFile = h(c.green),
        OilLink = h(c.magenta),
        OilLinkTarget = h(c.yellow),

        ----------------------
        --- Oil Git Status ---
        ----------------------
        OilGitStatusIndexUnmodified = h(c.grey),
        OilGitStatusWorkingTreeUnmodified = h(c.grey),
        OilGitStatusIndexIgnored = h(c.semidark),
        OilGitStatusWorkingTreeIgnored = h(c.semidark),
        OilGitStatusIndexUntracked = h(c.darkblue),
        OilGitStatusWorkingTreeUntracked = h(c.darkblue),
        OilGitStatusIndexAdded = h(c.green),
        OilGitStatusWorkingTreeAdded = h(c.green),
        OilGitStatusIndexCopied = h(c.cyan),
        OilGitStatusWorkingTreeCopied = h(c.cyan),
        OilGitStatusIndexDeleted = h(c.red),
        OilGitStatusWorkingTreeDeleted = h(c.red),
        OilGitStatusIndexModified = h(c.yellow),
        OilGitStatusWorkingTreeModified = h(c.yellow),
        OilGitStatusIndexRenamed = h(c.cyan),
        OilGitStatusWorkingTreeRenamed = h(c.cyan),
        OilGitStatusIndexTypeChanged = none,
        OilGitStatusWorkingTreeTypeChanged = none,
        OilGitStatusIndexUnmerged = h(c.darkred),
        OilGitStatusWorkingTreeUnmerged = h(c.darkred),

        --------------
        --- Neogit ---
        --------------

        --> Main page <--

        NeogitSectionHeader = h(c.red),
        NeogitRemote = h(c.cyan),
        NeogitBranch = h(c.orange),
        NeogitBranchHead = h(c.orange),
        NeogitCommitViewHeader = title,

        --> Hunk preview page <--

        NeogitDiffAdd = h(nil, '#002200'),
        NeogitDiffDelete = h(nil, '#220000'),
        NeogitDiffAddHighlight = h(nil, '#003300'),
        NeogitDiffDeleteHighlight = h(nil, '#330000'),
        NeogitDiffAddCursor = h(nil, '#004400'),
        NeogitDiffDeleteCursor = h(nil, '#440000'),
        NeogitDiffContextHighlight = h(nil, c.black),
        NeogitDiffContextCursor = h(nil, c.dark),
        NeogitHunkHeader = title,
        NeogitHunkHeaderCursor = title,
        NeogitHunkHeaderHighlight = title,
        NeogitHunkMergeHeader = title,
        NeogitHunkMergeHeaderCursor = title,
        NeogitHunkMergeHeaderHighlight = title,
        NeogitDiffAdditions = h(c.green),
        NeogitDiffDeletions = h(c.red),
        NeogitFilePath = h(c.orange),
        NeogitDiffHeader = h(c.red, c.black, b),
        NeogitDiffHeaderHighlight = h(c.red, c.black, b),

        --> Graph <--

        NeogitObjectId = h(c.green),
        NeogitChangeModified = h(c.yellow),
        NeogitChangeNewFile = h(c.green),
        NeogitChangeRenamed = h(c.magenta),
        NeogitChangeDeleted = h(c.red),
        NeogitActiveItem = h(c.magenta, c.dark),
        NeogitGraphBoldBlue = h(c.orange),

        -------------------
        --- Status Line ---
        -------------------

        CustomStatusLineDefault = h(c.white),
        CustomStatusLineRegister = h(c.orange),
        CustomStatusLineHardtime = h(c.magenta),
        CustomStatusLineGood = h(c.green),
        CustomStatusLineBad = h(c.red),
        CustomStatusLineUnkown = none,
        CustomStatusLineFilename = h(c.yellow),
        CustomStatusLineTime = h(c.magenta),
        CustomStatusLinePosition = h(c.yellow),

        --> Modes <--
        CustomStatusLineNormal = h(c.white, c.darkblue),
        CustomStatusLineInsert = h(c.white, c.darkgreen),
        CustomStatusLineSelect = h(c.white, c.purple),
        CustomStatusLineSelectLine = h(c.white, c.purple),
        CustomStatusLineSelectBlock = h(c.white, c.purple),
        CustomStatusLineVisual = h(c.white, c.darkred),
        CustomStatusLineVisualLine = h(c.white, c.darkred),
        CustomStatusLineVisualBlock = h(c.white, c.darkred),
        CustomStatusLineCommand = h(c.white, c.darkmagenta),
        CustomStatusLineReplace = h(c.white, c.darkcyan),
        CustomStatusLineTerminal = h(c.white, c.brown),

        --> Symbols <-
        CustomStatusLineNormalSymbol = h(c.black),
        CustomStatusLineInsertSymbol = h(c.truegreen),
        CustomStatusLineSelectSymbol = h(c.magenta),
        CustomStatusLineSelectLineSymbol = h(c.magenta),
        CustomStatusLineSelectBlockSymbol = h(c.magenta),
        CustomStatusLineVisualSymbol = h(c.truered),
        CustomStatusLineVisualLineSymbol = h(c.truered),
        CustomStatusLineVisualBlockSymbol = h(c.truered),
        CustomStatusLineCommandSymbol = h(c.magenta),
        CustomStatusLineReplaceSymbol = h(c.cyan),
        CustomStatusLineTerminalSymbol = h(c.green),
        -- 	CustomStatusLineTerminalSymbol = h(c.yellow),

        --> Battery <--
        CustomStatusLineBatteryCharging = h(c.green),
        CustomStatusLineBatteryDischarging = h(c.red),

        ----------------
        --- DevIcons ---
        ----------------

        DevIconSh = h(c.yellow),
        DevIconLua = h(c.cyan),
        DevIconRs = h(c.rust),
        DevIconTypeScript = h(c.darkcyan),
        DevIconTsx = h(c.darkcyan),
        DevIconPrisma = h(c.magenta),
        DevIconPy = h(c.yellow),
        DevIconDefault = h(c.red),
        DevIconOil = h(c.green),
        DevIconToml = h(c.grey),
        DevIconLock = h(c.grey),
        DevIconMd = h(c.magenta),
        DevIconCheckhealth = h(c.red),
        DevIconGitLogo = h(c.orange),
        DevIconGit = h(c.orange),

        -----------
        --- CSV ---
        -----------

        csvCol0 = h(c.red),
        csvCol1 = h(c.green),
        csvCol2 = h(c.cyan),
        csvCol3 = h(c.magenta),
        csvCol4 = h(c.grey),
        csvCol5 = h(c.orange),
        csvCol6 = h(c.darkcyan),
        csvCol7 = h(c.white),
        csvCol8 = h(c.yellow),

        ------------
        --- TODO ---
        ------------

        Todo = h(c.magenta),
        Hack = h(c.magenta),
        Warn = h(c.magenta),
        Perf = h(c.magenta),
        Note = h(c.magenta),
        Test = h(c.magenta),
        Fix = h(c.magenta),

        TodoUnchecked = h(c.red),
        TodoChecked = h(c.green),
        TodoPartial = h(c.orange),
        TodoHold = h(c.darkcyan),
        Hide = h(c.semidark, c.black),

        CommentBg = h(c.semidark, c.semidark),
        None = none,
        FunctionItalic = h(c.green, nil, i),
}

for name, value in pairs(c) do
        colours[name] = h(value[1])
        colours['bg-' .. name] = h(c.dark, value[1])
        colours['bg-hide-' .. name] = h(value[1], value[1])
end

for name, options in pairs(colours) do
        vim.api.nvim_set_hl(0, name, options)
end

colours['true_colours'] = c

return colours
