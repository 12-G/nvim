local uv, fn = vim.loop, vim.fn

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
    performance = {
        rtp = {
            disabled_plugins = {
                        "gzip",
                        "tar",
                        "tarPlugin",
                        "zip",
                        "zipPlugin",
                        "getscript",
                        "getscriptPlugin",
                        "vimball",
                        "vimballPlugin",
                        "2html_plugin",
                        "logipat",
                        "rrhelper",
                        "netrw",
                        "netrwPlugin",
                        "netrwSettings",
                        "netrwFileHandlers",
                        "rplugin",
                        "syntax",
                        "synmenu",
                        "optwin",
                        "compiler",
                        "ftplugin",
                        "bugreport",
                        "matchit",
                        -- "matchparen",
                        "tohtml",
                        "tutor",
                        "spellfile_plugin",
            }
        }
    }

}

require('lazy').setup("modules", opts)

require('core.options')
require('core.keymap')
