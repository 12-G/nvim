local config = {}

function config.galaxyline()
    local gl = require('galaxyline')
    local gls = gl.section
    gl.short_line_list = {'NvimTree','vista','dbui'}

    local colors = {
        bg = '#202328',
        fg = '#bbc2cf',
        yellow = '#fabd2f',
        cyan = '#008080',
        darkblue = '#081633',
        green = '#98be65',
        orange = '#FF8800',
        violet = '#a9a1e1',
        magenta = '#c678dd',
        blue = '#51afef';
        red = '#ec5f67';
    }

    local buffer_not_empty = function()
        if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
            return true
        end
        return false
    end

    gls.left[1] = {
        RainbowRed = {
            provider = function() return '▊ ' end,
            highlight = {colors.blue,colors.bg}
        },
    }
    gls.left[2] = {
        ViMode = {
            provider = function()
                -- auto change color according the vim mode
                local mode_color = {
                    n = colors.magenta, i = colors.green,v=colors.blue,
                    [''] = colors.blue,V=colors.blue,
                    c = colors.red,no = colors.magenta,s = colors.orange,
                    S=colors.orange,[''] = colors.orange,
                    ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                    cv = colors.red,ce=colors.red, r = colors.cyan,
                    rm = colors.cyan, ['r?'] = colors.cyan,
                    ['!']  = colors.red,t = colors.red}
                    vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
                    return '  '
                end,
                highlight = {colors.red,colors.bg,'bold'},
            },
        }
        gls.left[3] = {
            FileSize = {
                provider = 'FileSize',
                condition = buffer_not_empty,
                highlight = {colors.fg,colors.bg}
            }
        }
        gls.left[4] ={
            FileIcon = {
                provider = 'FileIcon',
                condition = buffer_not_empty,
                highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
            },
        }

        gls.left[5] = {
            FileName = {
                provider = {'FileName'},
                condition = buffer_not_empty,
                highlight = {colors.green,colors.bg,'bold'}
            }
        }

        gls.left[6] = {
            LineInfo = {
                provider = 'LineColumn',
                separator = ' ',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.fg,colors.bg},
            },
        }

        gls.mid[1] = {
            DiagnosticError = {
                provider = 'DiagnosticError',
                icon = '  ',
                highlight = {colors.red,colors.bg}
            }
        }
        gls.mid[2] = {
            DiagnosticWarn = {
                provider = 'DiagnosticWarn',
                icon = '  ',
                highlight = {colors.yellow,colors.bg},
            }
        }

        gls.mid[3] = {
            DiagnosticHint = {
                provider = 'DiagnosticHint',
                icon = '  ',
                highlight = {colors.cyan,colors.bg},
            }
        }

        gls.mid[4] = {
            DiagnosticInfo = {
                provider = 'DiagnosticInfo',
                icon = '  ',
                highlight = {colors.blue,colors.bg},
            }
        }

        gls.right[1] = {
            PerCent = {
                provider = 'LinePercent',
                separator = ' ',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.fg,colors.bg,'bold'},
            }
        }

        gls.right[2] = {
            FileEncode = {
                provider = 'FileEncode',
                separator = ' ',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.cyan,colors.bg,'bold'}
            }
        }

        gls.right[3] = {
            FileFormat = {
                provider = 'FileFormat',
                separator = ' ',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.cyan,colors.bg,'bold'}
            }
        }

        gls.right[4] = {
            GitIcon = {
                provider = function() return '  ' end,
                condition = require('galaxyline.provider_vcs').check_git_workspace,
                separator = ' ',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.violet,colors.bg,'bold'},
            }
        }

        gls.right[5] = {
            GitBranch = {
                provider = 'GitBranch',
                condition = require('galaxyline.provider_vcs').check_git_workspace,
                highlight = {colors.violet,colors.bg,'bold'},
            }
        }

        local checkwidth = function()
            local squeeze_width  = vim.fn.winwidth(0) / 2
            if squeeze_width > 40 then
                return true
            end
            return false
        end

        gls.right[5] = {
            DiffAdd = {
                provider = 'DiffAdd',
                condition = checkwidth,
                icon = '  ',
                highlight = {colors.green,colors.bg},
            }
        }
        gls.right[6] = {
            DiffModified = {
                provider = 'DiffModified',
                condition = checkwidth,
                icon = ' 柳',
                highlight = {colors.orange,colors.bg},
            }
        }
        gls.right[7] = {
            DiffRemove = {
                provider = 'DiffRemove',
                condition = checkwidth,
                icon = '  ',
                highlight = {colors.red,colors.bg},
            }
        }

        gls.right[8] = {
            RainbowBlue = {
                provider = function() return ' ▊' end,
                highlight = {colors.blue,colors.bg}
            },
        }

        gls.short_line_left[1] = {
            BufferType = {
                provider = 'FileTypeName',
                separator = ' ',
                separator_highlight = {'NONE',colors.bg},
                highlight = {colors.blue,colors.bgr,'bold'}
            }
        }

        gls.short_line_left[2] = {
            SFileName = {
                provider = function ()
                    local fileinfo = require('galaxyline.provider_fileinfo')
                    local fname = fileinfo.get_current_file_name()
                    for _,v in ipairs(gl.short_line_list) do
                        if v == vim.bo.filetype then
                            return ''
                        end
                    end
                    return fname
                end,
                condition = buffer_not_empty,
                highlight = {colors.white,colors.bg,'bold'}
            }
        }

        gls.short_line_right[1] = {
            BufferIcon = {
                provider= 'BufferIcon',
                highlight = {colors.fg,colors.bg}
            }
        }
    end

    function config.indentmini()
        local indent = require('indentmini').setup({
            char = '▏',
        })
        vim.cmd.highlight('default link IndentLine Comment')
    end

    function config.dashboard()
        local db = require('dashboard')
        db.setup({
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                project = {
                    enable = true,
                },
                disable_move = true,
                shortcut = {
                    {
                        desc = 'Update',
                        icon = ' ',
                        group = 'Include',
                        action = 'Lazy update',
                        key = 'u',
                    },
                    {
                        icon = ' ',
                        desc = 'Find text',
                        group = 'Constant',
                        action = 'Telescope live_grep',
                        key = 'l',
                    },
                    {
                        icon = ' ',
                        desc = 'Files',
                        group = 'Function',
                        action = 'Telescope find_files find_command=rg,--ignore,--hidden,--files',
                        key = 'f',
                    },
                    {
                        icon = ' ',
                        desc = 'Quit',
                        group = 'Include',
                        action = 'qa',
                        key = 'q',
                    },
                },
            },
        })
    end

    return config
