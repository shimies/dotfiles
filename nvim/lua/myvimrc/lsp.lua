-- :h lsp-method
local augroup = vim.api.nvim_create_augroup("myvimrc.lsp", { clear = true })

-- Handles LspAttach event, configuring the buffer to which LSP has been attached.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_lsp_attach(client, bufnr)
    local configure_keymap = function() --- {{{
        local set_keymap = function(mode, keys, func, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, keys, func, opts)
        end

        set_keymap("n", "[lsp]", "<Nop>")
        set_keymap("n", "<Space><Space>", "[lsp]", { remap = true })

        if client:supports_method("textDocument/implementation") then
            set_keymap("n", "[lsp]I", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        end

        set_keymap("n", "[lsp]d", vim.lsp.buf.definition, { desc = "Go to definition" })
        set_keymap("n", "[lsp]D", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        set_keymap("n", "[lsp]I", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        set_keymap("n", "[lsp]y", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
        set_keymap("n", "[lsp]r", vim.lsp.buf.references, { desc = "List references" })

        set_keymap("n", "[lsp]ds", vim.lsp.buf.document_symbol, { desc = "List document symbols" })
        set_keymap("n", "[lsp]ws", vim.lsp.buf.workspace_symbol, { desc = "List workspace symbols" })

        -- keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Show documentation' })
        -- keymap('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Show signature' })
        -- keymap('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature' })

        -- keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
        -- keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })

        -- keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
        -- keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
        -- keymap(
        -- 'n',
        -- '<leader>wl',
        -- function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        -- { desc = 'List workspace folders' }
        -- )
    end --- }}}
    configure_keymap()
    vim.api.nvim_clear_autocmds {
        buffer = bufnr,
        group = augroup,
    } -- just in case the save buffer is reused then attached after its close
    if client:supports_method("textDocument/completion") then
        -- FIXME Disable all of the followings when cmp_nvim_lsp is in use
        -- Optional: trigger autocompletion on EVERY keypress. May be slow!
        -- local chars = {}
        -- for i = 32, 126 do
        --     table.insert(chars, string.char(i))
        -- end
        -- client.server_capabilities.completionProvider.triggerCharacters = chars
        -- vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format { bufnr = bufnr, id = client.id, timeout_ms = 3000 }
            end,
            group = augroup,
        })
    end
    -- if client:supports_method("textDocument/hover") then
    --     vim.api.nvim_create_autocmd({ "CursorHold" }, {
    --         buffer = bufnr,
    --         callback = function()
    --             vim.lsp.buf.hover {
    --                 focus = false,
    --                 border = "single",
    --                 close_events = { "CursorMoved", "FocusLost", "ModeChanged" },
    --             }
    --         end,
    --         group = augroup,
    --     })
    -- end
    if client:supports_method("textDocument/documentHighlight") then
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
            group = augroup,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
            group = augroup,
        })
    end
end

vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local function configure_autocmd()
    -- Reference: `:h lsp-attach`
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
        callback = function(args)
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
            local bufnr = args.buf
            local _, err = pcall(on_lsp_attach, client, bufnr)
            if err then
                vim.notify("[on_lsp_attach] error: " .. err, vim.log.levels.ERROR)
            else
                vim.notify("[on_lsp_attach] " .. client.name .. " attached to buffer " .. bufnr, vim.log.levels.INFO)
            end
        end,
        group = augroup,
    })
end
configure_autocmd()

local function configure_diagnostic()
    -- Reference: `:h vim.diagnostic`
    ---@type vim.diagnostic.Opts
    local opts = {
        underline = true,
        virtual_text = {
            current_line = true,
            source = false,
        },
        float = {           -- fired by <C-w>d
            header = {},
            source = false, -- `source` is explicitly set to show in format
            format = function(diag)
                return string.format("[%s]: %s", diag.source, diag.message)
            end,
            prefix = function(_, i, _)
                return string.format("%d. ", i), ""
            end,
            suffix = function(diag, _, _)
                if diag.code then
                    return string.format(" (%s)", diag.code), ""
                else
                    return "", ""
                end
            end,
            border = "single", -- see 'winborder'
        },
        severity_sort = true,
    }
    vim.diagnostic.config(opts)
end
configure_diagnostic()
