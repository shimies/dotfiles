local M = {}

--==--==--==--==--==--==--==--==--==--==--==--==--
-- Helper functions
--==--==--==--==--==--==--==--==--==--==--==--==--
local modes = { -- {{{ list of available modes
    n        = "normal",
    op       = "o-pending",
    vc       = "visual",
    vl       = "visual-line",
    vb       = "visual-block",
    sc       = "select",
    sl       = "select-line",
    sb       = "select-block",
    i        = "insert",
    r        = "replace",
    vr       = "visual-replace",
    command  = "command",
    ex       = "ex",
    more     = "more",
    confirm  = "confirm",
    shell    = "shell",
    terminal = "terminal",
}                      -- }}}

local code_to_mode = { -- {{{ mapping of mode code to mode; see `:help mode()`
    ["n"]     = modes.n,
    ["no"]    = modes.op,
    ["nov"]   = modes.op,
    ["noV"]   = modes.op,
    ["no\22"] = modes.op,
    ["niI"]   = modes.n,
    ["niR"]   = modes.n,
    ["niV"]   = modes.n,
    ["nt"]    = modes.n,
    ["ntT"]   = modes.n,
    ["v"]     = modes.vc,
    ["vs"]    = modes.vc,
    ["V"]     = modes.vl,
    ["Vs"]    = modes.vl,
    ["\22"]   = modes.vb,
    ["\22s"]  = modes.vb,
    ["s"]     = modes.sc,
    ["S"]     = modes.sl,
    ["\19"]   = modes.sb,
    ["i"]     = modes.i,
    ["ic"]    = modes.i,
    ["ix"]    = modes.i,
    ["R"]     = modes.r,
    ["Rc"]    = modes.r,
    ["Rx"]    = modes.r,
    ["Rv"]    = modes.vr,
    ["Rvc"]   = modes.vr,
    ["Rvx"]   = modes.vr,
    ["c"]     = modes.command,
    ["cr"]    = modes.command,
    ["cv"]    = modes.ex,
    ["cvr"]   = modes.ex,
    ["r"]     = modes.r,
    ["rm"]    = modes.more,
    ["r?"]    = modes.confirm,
    ["!"]     = modes.shell,
    ["t"]     = modes.t,
}                          --- }}}

local mode_expressions = { -- {{{ mode names to be displayed for each mode
    [modes.n]        = { "N", "NORMAL" },
    [modes.op]       = { "OP", "O-PENDING" },
    [modes.vc]       = { "V", "VISUAL" },
    [modes.vl]       = { "VL", "VISUAL[L]" },
    [modes.vb]       = { "VB", "VISUAL[B]" },
    [modes.sc]       = { "S", "SELECT" },
    [modes.sl]       = { "SL", "SELECT[L]" },
    [modes.sb]       = { "SB", "SELECT[B]" },
    [modes.i]        = { "I", "INSERT" },
    [modes.r]        = { "R", "REPLACE" },
    [modes.vr]       = { "VR", "VISUAL[R]" },
    [modes.command]  = { "!", "COMMAND" },
    [modes.ex]       = { "EX", "EX" },
    [modes.more]     = { "M", "MORE" },
    [modes.confirm]  = { "Y?", "CONFIRM" },
    [modes.shell]    = { "SH", "SHELL" },
    [modes.terminal] = { "T", "TERMINAL" },
} -- }}}

local function mode_string()
    local mode_code = vim.api.nvim_get_mode().mode
    if code_to_mode[mode_code] == nil then
        return mode_code
    end
    local exprs = mode_expressions[code_to_mode[mode_code]]
    if vim.api.nvim_win_get_width(0) < 100 then
        return exprs[1]
    else
        return exprs[2]
    end
end


--==--==--==--==--==--==--==--==--==--==--==--==--
-- Options
--==--==--==--==--==--==--==--==--==--==--==--==--
local opt = vim.opt
local function statusline()
    local components = {
        -- string.format([=[|%%{v:lua.require'%s'.mode_string()}|]=], this),
        [==[%<]==],
        [==[%f]==],
        [==[%{' '}]==],
        [==[%m]==],
        [==[%{&readonly?'[RO]':''}]==],
        [==[%{&filetype=='help'?'[HELP]':''}]==],
        [==[%{&previewwindow?'[PREV]':''}]==],
        [==[%=]==],
        [==[%{'['.(&fileencoding!=''?&fileencoding:&encoding).'/'.&fileformat.']'}]==],
        [==[[%03l,%03v][%3p%%]]==],
    }
    return table.concat(components)
end

-- Statusline settings
opt.laststatus = 2 -- condition to show status line (always)
-- opt.title = true -- show title on status line
-- opt.ruler = true -- show cursor position on status line
opt.statusline = statusline()


--==--==--==--==--==--==--==--==--==--==--==--==--
-- Autocmds
--==--==--==--==--==--==--==--==--==--==--==--==--
local hlname = "StatusLine"
local hl = vim.api.nvim_get_hl(0, { name = hlname }) ---@type table
local myaugroup = vim.api.nvim_create_augroup("myvimrc.statusline", { clear = true })

-- Update statusline hl (see `:highlight') depending on the event triggered by autocmd
local function update_statusline_hl(event)
    if event == "InsertEnter" then
        -- TODO cterm
        vim.api.nvim_set_hl(0, hlname, {
            bold    = true,
            fg      = "LightCyan",
            bg      = "Orange",
            cterm   = { bold = true },
            ctermfg = "LightCyan",
            ctermbg = "DarkYellow",
        })
    elseif event == "InsertLeave" then
        vim.api.nvim_set_hl(0, hlname, hl)
    end
end

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    pattern = { "*" },
    callback = function(args) update_statusline_hl(args.event) end,
    group = myaugroup,
})


--==--==--==--==--==--==--==--==--==--==--==--==--
-- Exports
--==--==--==--==--==--==--==--==--==--==--==--==--
M = {
    mode_string = mode_string,
}
return M
