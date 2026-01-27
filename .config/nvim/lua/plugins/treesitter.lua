local M = {}
table.insert(M, { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 10 } })
table.insert(M, {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    version = false,
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        }
    },
    build = ':TSUpdate',
    lazy = false,
    config = function()
        -- See `:help nvim-treesitter`
        require('nvim-treesitter').setup(
            {
                ensure_installed = {
                    'c', 'cpp', 'lua', 'python', 'rust', 'tsx',
                    'javascript', 'typescript', 'vimdoc', 'vim', 'bash',
                    'markdown', 'markdown_inline', 'comment', 'gitignore', 'json',
                    'toml', 'sql', 'requirements', 'yaml', 'xml', 'terraform',
                    'gomod', 'gowork', 'gosum', 'go',
                },
                auto_install = false,

                highlight = {
                    enable = true,
                    -- regex highlighting is turned on for better spell checking.
                    -- In the case of performance issues, turn this off
                    additional_vim_regex_highlighting = true,
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                },
            }
        )
    end
})
return M
