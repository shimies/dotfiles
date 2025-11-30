local M = {}
local prefix = (...)

local function submodule(name)
    return string.format("%s.%s", prefix, name)
end

require(submodule("options"))
require(submodule("commands"))
require(submodule("keymaps"))
require(submodule("autocmds"))
require(submodule("colorscheme"))
require(submodule("statusline"))

local function hook_post_plugin_load()
    require(submodule("lsp"))
end

-- [[[ Plugin manager - lazy.nvim ]]] {{{
local function init_lazy_nvim() -- Reference: https://lazy.folke.io/installation
    local module = "lazy"
    local install_path = vim.fs.joinpath(vim.fn.stdpath("data"), module, "lazy.nvim")
    local load_module = function()
        vim.opt.runtimepath:prepend(install_path)
        if not package.loaded[module] then
            require(module).setup(submodule("plugins"), {
                change_detection = {
                    enabled = false,
                },
            })
        end
    end
    if vim.uv.fs_stat(install_path) then
        load_module()
        hook_post_plugin_load()
    else
        vim.system(
            {
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable", -- latest stable release
                install_path,
            },
            {
                stdout = false,
                text = true,
            },
            vim.schedule_wrap(function(out)
                if out.code == 0 then
                    load_module()
                    hook_post_plugin_load()
                else
                    vim.api.nvim_echo({
                        { "Plugin manager is disabled",                  "ErrorMsg" },
                        { " due to `git clone` failure: " .. out.stderr, "WarningMsg" },
                    }, true, {})
                end
            end)
        )
    end
end
init_lazy_nvim()
--- }}}

-- [[[ Exports ]]] {{{
return M
--- }}}
