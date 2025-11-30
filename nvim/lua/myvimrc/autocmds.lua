--==--==--==--==--==--==--==--==--==--==--==--==--
-- Autocommands
--==--==--==--==--==--==--==--==--==--==--==--==--
local myaugroup = vim.api.nvim_create_augroup("myvimrc", { clear = true })

-- Trim trailing white space characters
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
    group = myaugroup,
})

-- Jump to the last known position in a file (`:help last-position-jump')
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        local mark = [['"]] -- mark of "
        local prev_line = vim.fn.line(mark)
        if prev_line > 1 and prev_line <= vim.fn.line("$") then
            vim.cmd.normal { args = { "g" .. mark }, bang = true }
        end
    end,
    group = myaugroup,
})

-- Reload $MYVIMRC and its sub configs on saving files
local function reload_configs()
    local module = vim.env.MYVIMMODULE
    for name, _ in pairs(package.loaded) do
        if name:match("^" .. module) then
            package.loaded[name] = nil
        end
    end
    require(module)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = {
        vim.env.MYVIMRC,
        vim.fs.joinpath(vim.env.MYVIMHOME, "lua", vim.env.MYVIMMODULE, "*.lua"),
    },
    callback = function()
        reload_configs()
        vim.notify("Neovim configuration reloaded!", vim.log.levels.INFO)
    end,
    group = myaugroup,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = { "*" },
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
    group = myaugroup,
})
