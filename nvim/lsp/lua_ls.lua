---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    quote_style = "double",
                    trailing_table_separator = "smart",
                    insert_final_newline = "true",
                    break_all_list_when_line_exceed = "true",
                    call_arg_parentheses = "remove_table_only",
                },
            },
            type = {
                checkTableShape = false,
                inferParamType = false,
            },
            diagnostic = {
                neededFileStats = {
                    ["codestyle-check"] = "Any",
                },
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Reference:
-- * https://luals.github.io/wiki/settings/
-- * https://luals.github.io/wiki/formatter/
