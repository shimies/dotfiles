local opt = vim.opt
local parent = vim.iter(vim.split(..., ".", { plain = true })):rskip(1):join(".")
local utils = require(string.format("%s.%s", parent, "utils"))

local function reset_to_default(accessor, option)
    -- NOTE ALSO:
    -- vim.opt.$(name)._info returns a table that contains a `default' key holding the default value
    accessor[option] = vim.api.nvim_get_option_info2(option, { scope = "global" }).default
end

--==--==--==--==--==--==--==--==--==--==--==--==--
-- For functionality
--==--==--==--==--==--==--==--==--==--==--==--==--
-- Enable copy and paste with OS clipboard
opt.clipboard = { "unnamed", "unnamedplus" }

-- Character encodings and newline
opt.encoding = "utf-8"
opt.fileformats:append { "mac" }
opt.fileencodings = { "utf-8", "iso-2022-jp", "cp932", "euc-jp", "default", "latin1" }

-- Save undo file for recovering
opt.undofile      = true -- Enable the feature
opt.undolevels    = 4096 -- Maximum number of changes that can be undone
opt.undoreload    = 0    -- Maximum number of lines to save on a buffer reload

-- File and buffer control
opt.confirm       = true
opt.hidden        = true
opt.autoread      = true
opt.autowrite     = false
opt.autowriteall  = false
opt.backup        = false
opt.swapfile      = false
opt.writebackup   = true

-- Command-line
opt.wildmenu      = true
opt.wildmode      = { "longest:full", "full" }
opt.history       = 10000

-- Backspace and other control keys' action
-- * insert mode: allow <BS> to take effect over indents, eols and insert-start position
-- * normal mode: do not allow <BS> and <Space> to move across lines
opt.backspace     = { "indent", "eol", "start" }
opt.whichwrap:remove { "b", "s" }

-- Characters recognized by <C-a> and <C-x>
opt.nrformats = { "bin", "hex", "unsigned" }

-- Virtual editing
-- * allow the cursor to move into no-character-present area in visual block mode
opt.virtualedit:append { "block" }

-- Display multi-byte symbol properly (TODO)
opt.ambiwidth     = "double"

-- Scrolling
opt.scrolljump    = 1
opt.scrolloff     = 5
opt.sidescroll    = 1
opt.sidescrolloff = 10

-- Tab
opt.expandtab     = true -- expand tab into spaces
opt.tabstop       = 4    -- Tab (ASCII:0x09) width on display
opt.softtabstop   = 4    -- Width inserted on pushing tab key
opt.smarttab      = true

-- Indent control
opt.shiftwidth    = 4     -- automatic indent width
opt.autoindent    = true  -- inherit indent level of previous line
opt.smartindent   = true  -- in addition to above, recognize c syntax
opt.cindent       = false -- smarter than two modes above
opt.cinoptions    = ">s,Ls,:0,l1,g0,t0,i0,+s,(s,U1,m1"
-- opt.copyindent = true
-- opt.indentexpr = '' -- run vim script

-- Pair(s) of characters recognized by `%' command
opt.matchpairs:append { "<:>" }

-- Folding
opt.foldmethod     = "marker"
opt.foldlevel      = 0
opt.foldlevelstart = -1

-- Searching
opt.incsearch      = true  -- incremental search
opt.hlsearch       = true  -- highlight search
opt.wrapscan       = false -- search wrap around the end of file
opt.ignorecase     = true  -- ignore case in search patterns
opt.smartcase      = true  -- no ignore case when pattern has uppercase
opt.gdefault       = false -- if `g' mode should be enabled by default in `:s' command

-- Substitution
opt.inccommand     = "split"

-- Direction of split
opt.splitbelow     = true
opt.splitright     = true

-- Time after which CursorHold is triggered (mostly for LSP)
opt.updatetime     = 750

-- Timeout
opt.timeout        = true
opt.ttimeout       = true
opt.timeoutlen     = 1000
opt.ttimeoutlen    = 100

-- Formatting on end of line
opt.textwidth      = 0
reset_to_default(opt, "wrapmargin")
reset_to_default(opt, "formatoptions")
reset_to_default(opt, "paste")
-- opt.colorcolumn = 100 -- making redrawing slower
opt.breakindent = true

-- Enable mouse control (TODO)
-- opt.mouse = 'a'

-- Enable modeline (vim settings found at the beginning or end of the file)
opt.modeline = true

-- Disable beep sounds
opt.visualbell = true
opt.errorbells = false

-- For input completion
opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }


--==--==--==--==--==--==--==--==--==--==--==--==--
-- For appearance
--==--==--==--==--==--==--==--==--==--==--==--==--
-- Visualize blank characters (TODO)
opt.list          = true -- enable showing listchars
opt.listchars     = { tab = ">-", trail = "-", extends = ">", precedes = "<", nbsp = "%" }

-- Visual settings
opt.number        = true  -- show line number
opt.wrap          = false -- show with long content wrapped
opt.showcmd       = true  -- show command on command line
opt.cmdheight     = 2     -- height of command line
opt.showmatch     = true  -- highlight matching brace of bracket
opt.matchtime     = 3     -- tenths of a second to show matching
-- opt.helpheight   = 1023
-- FIXME options below are useful but unset because it makes redrawing slower
-- opt.cursorline   = false -- highlight line of cursor
-- opt.cursorcolumn = true  -- highlight screen column of cursor

-- Tabline settings (TODO)
-- opt.showtabline = 1
-- opt.tabline     = %!MyTabLine()

-- Enable true colors and pseudo-transparency for popup-menu and floating-window
opt.termguicolors = true
opt.pumblend      = 10
opt.winblend      = 20


--==--==--==--==--==--==--==--==--==--==--==--==--
-- Environment specific options
--==--==--==--==--==--==--==--==--==--==--==--==--
-- Deal with problem that input method is enabled
-- when enter insert and search mode under Windows
-- TODO
-- opt.iminsert = 0
-- opt.imsearch = -1

-- Forward slash is used when expanding file names
if utils.is_windows() and vim.fn.exists("+shellslash") == 1 then
    opt.shellslash = true
end
