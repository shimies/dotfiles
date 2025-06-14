return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    event = { "FileType" },
    -- TODO event = { "BufEnter", "BufReadPre", "BufNewFile" },
    opts = {
        ensure_installed = {
            "gopls",
            "jdtls",
            "lua_ls",
            "pyright",
            "ruff",
        },
    },
}
