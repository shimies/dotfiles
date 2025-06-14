---@type vim.lsp.Config
return {
    settings = {
        pyright = {
            typeCheckingMode = "strict",
            disableOrganizeImports = true, -- Using Ruff's import organizer
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                --   -> which is good but there is a drawback that disables type checking :thinking:
                -- ignore = { "*" },
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
            },
        },
    },
}

-- Reference:
-- * https://github.com/microsoft/pyright/blob/main/docs/settings.md
