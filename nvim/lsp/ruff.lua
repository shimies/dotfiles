local utils = require("myvimrc.utils")

---@type vim.lsp.Config
return {
    init_options = {
        settings = {
            configuration = vim.fs.joinpath(utils.path_of_this_dir(), "ruff", "ruff.toml"),
            configurationPreference = "filesystemFirst",
            lint = {
                enable = true,
            },
        },
    },
}

-- Reference:
-- * https://docs.astral.sh/ruff/editors/settings/
-- * How config file should be written:
--   * https://docs.astral.sh/ruff/settings/
--   * https://docs.astral.sh/ruff/rules/
