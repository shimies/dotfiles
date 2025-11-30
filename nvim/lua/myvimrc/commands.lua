--==--==--==--==--==--==--==--==--==--==--==--==--
-- User-defined commands
--==--==--==--==--==--==--==--==--==--==--==--==--
local parent = vim.iter(vim.split(..., ".", { plain = true })):rskip(1):join(".")
local utils = require(string.format("%s.%s", parent, "utils"))

vim.api.nvim_create_user_command("Bdelete",
    function()
        utils.clear_buffer(false)
    end, {
        desc = "bdelete, keeping the window open",
    })
vim.api.nvim_create_user_command("Bwipeout",
    function()
        utils.clear_buffer(true)
    end, {
        desc = "bwipeout, keeping the window open",
    })
