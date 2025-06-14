return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter", "FileType" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "mason-org/mason-lspconfig.nvim",
    },
    opts = function()
        local cmp = require("cmp")
        return {
            mapping = cmp.mapping.preset.insert(),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }, {
                { name = "path" },
            }),
        }
    end,
}
