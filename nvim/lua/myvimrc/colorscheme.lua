local parent = vim.iter(vim.split(..., ".", { plain = true })):rskip(1):join(".")
local utils = require(string.format("%s.%s", parent, "utils"))

local function preferred_colorscheme()
    if utils.is_windows() then
        return "wombat256mod"
    elseif utils.is_cygwin() then
        return "wombat256mod"
    elseif utils.is_real_tty() then
        return "desert"
    else
        return "wombat256mod"
    end
end

-- Enable color scheme
if vim.fn.has("syntax") == 1 then
    vim.cmd.syntax("on")
end
vim.cmd.colorscheme(preferred_colorscheme())

-- Adjust color scheme for my taste
if vim.g.colors_name == "wombat256mod" then
    vim.opt.background = "dark"
    -- vim.opt.background = "light"
    vim.cmd.highlight { args = { "Comment", "gui=NONE" } }
    vim.cmd.highlight { args = { "StatusLine", "gui=NONE" } }
    vim.cmd.highlight { args = { "String", "gui=NONE" } }
end

-- Other color schemes of my choice are:
-- * evening
-- * slate
-- * sorbet
-- * vim
-- These are installed by default (at ${install_dir}/share/nvim/runtime/colors)
