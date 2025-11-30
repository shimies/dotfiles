local M = {}

--==--==--==--==--==--==--==--==--==--==--==--==--
-- Path manipulation
--==--==--==--==--==--==--==--==--==--==--==--==--
local function path_of_this_dir()
    local file_path = debug.getinfo(2, "S").source
    if file_path:sub(1, 1) == "@" then
        return vim.fs.dirname(file_path:sub(2, file_path:len()))
    else
        error("location of calling function could not be determined")
    end
end

--==--==--==--==--==--==--==--==--==--==--==--==--
-- OS detection
--==--==--==--==--==--==--==--==--==--==--==--==--
local function is_windows()
    return vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
end

local function is_cygwin()
    return vim.fn.has("win32unix") == 1
end

local function is_real_tty()
    return vim.env.TERM == "linux"
end

-- TODO
-- function M.organizeImports(bufnr)
--     local params = vim.lsp.util.make_range_params()
--     params.context = { only = { 'source.organizeImports' } }
--     local result = vim.lsp.buf_request_sync(bufnr, 'textDocument/codeAction', params, 500)
--     for cid, res in pairs(result or {}) do
--         for _, r in pairs(res.result or {}) do
--             if r.edit then
--                 local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
--                 vim.lsp.util.apply_workspace_edit(r.edit, enc)
--                 return
--             end
--         end
--     end
-- end

--==--==--==--==--==--==--==--==--==--==--==--==--
-- Clearing buffer without closing windows
--==--==--==--==--==--==--==--==--==--==--==--==--
local function buflisted(bufnr)
    return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
end

local function bufexists(bufnr)
    return vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr)
end

local function change_buffer_fixed(winnr, from, to)
    local b = vim.api.nvim_win_get_buf(winnr)
    if b == from then
        vim.api.nvim_win_call(winnr, function()
            vim.cmd.buffer { args = { to }, bang = true }
        end)
    end
end

local function change_buffer_smart(winnr, target)
    local b = vim.api.nvim_win_get_buf(winnr)
    if b == target then
        vim.api.nvim_win_call(winnr, function()
            -- bufnr('#') is window-scoped
            -- i.e. different windows could show different output of bufnr('#')
            local altbuf = vim.fn.bufnr("#")
            if altbuf > 0 and buflisted(altbuf) and altbuf ~= target then
                vim.cmd.buffer("#")
            else
                vim.cmd.bnext()
            end
        end)
    end
end

local function clear_buffer(is_wipeout)
    local command = (is_wipeout and "bwipeout") or "bdelete"
    local currbuf = vim.api.nvim_get_current_buf()

    -- if not listed, execute the command with force, closing the window
    if not buflisted(currbuf) then
        vim.cmd { cmd = command, bang = true } -- TODO bang?
        return
    end

    local listedbufs = 0
    local jumpingbuf = 0
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if bufnr ~= currbuf then
            if buflisted(bufnr) then
                listedbufs = listedbufs + 1
            elseif bufexists(bufnr) then
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:len() == 0 and jumpingbuf == 0 then
                    jumpingbuf = bufnr
                end
            end
        end
    end

    -- switch buffers in all windows if the buffer is about to be cleared
    local change_buffer
    if listedbufs == 0 then
        local to = jumpingbuf
        if jumpingbuf == 0 then
            vim.cmd.enew()
            to = vim.api.nvim_get_current_buf()
        end
        change_buffer = function(winnr)
            change_buffer_fixed(winnr, currbuf, to)
        end
    else
        change_buffer = function(winnr)
            change_buffer_smart(winnr, currbuf)
        end
    end
    for _, winnr in ipairs(vim.api.nvim_list_wins()) do
        change_buffer(winnr)
    end

    -- finally clear the target buffer
    vim.cmd { cmd = command, args = { currbuf }, bang = true }
    if listedbufs == 0 then
        vim.opt_local.buflisted = true
        vim.opt_local.bufhidden = ""
        vim.opt_local.buftype = ""
    end
end

--==--==--==--==--==--==--==--==--==--==--==--==--
-- Exports
--==--==--==--==--==--==--==--==--==--==--==--==--
M = {
    path_of_this_dir = path_of_this_dir,
    is_windows = is_windows,
    is_cygwin = is_cygwin,
    is_real_tty = is_real_tty,
    clear_buffer = clear_buffer,
}
return M
