local config = {}

function config.telescope()
    local fb_actions = require('telescope').extensions.file_browser.actions
    require('telescope').setup({
        defaults = {
            prompt_prefix = ' ',
            selection_caret = ' ',
            layout_config = {
                horizontal = { prompt_position = 'top', results_width = 0.6 },
                vertical = { mirror = false },
            },
            sorting_strategy = 'ascending',
            file_previewer = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        },
        extensions = {
            file_browser = {
                hijack_netrw = true,
                hidden = { file_browser = true },
                mappings = {
                    ['n'] = {
                        ['c'] = fb_actions.create,
                        ['r'] = fb_actions.rename,
                        ['d'] = fb_actions.remove,
                        ['o'] = fb_actions.open,
                        ['u'] = fb_actions.goto_parent_dir,
                        ['g'] = fb_actions.goto_cwd,
                        ["h"] = fb_actions.toggle_hidden,
                    },
                },
            },
        },
    })
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('file_browser')
end

function config.treesitter()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'c',
            'cpp',
            'rust',
            'lua',
            'python',
            'typescript',
            'javascript',
            'bash',
            'css',
            'scss',
            'diff',
            'html',
            'sql',
            'markdown',
            'markdown_inline',
            'json',
            'jsonc',
            'fish',
            'gitignore',
            'git_config',
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    })

end

return config
