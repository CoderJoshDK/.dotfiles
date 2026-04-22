local languages = {
    'c', 'cpp', 'lua', 'python', 'rust', 'tsx',
    'javascript', 'typescript', 'vimdoc', 'vim', 'bash',
    'markdown', 'markdown_inline', 'comment', 'gitignore', 'json',
    'toml', 'sql', 'requirements', 'yaml', 'xml', 'terraform',
    'gomod', 'gowork', 'gosum', 'go',
    'ruby', 'embedded_template', 'just',
}
local M = {}
table.insert(M, { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 10 } })
table.insert(M, {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    version = false,
    build = ':TSUpdate',
    lazy = false,
    config = function()
        -- replicate `ensure_installed`, runs asynchronously, skips existing languages
        require('nvim-treesitter').install(languages)
        require('nvim-treesitter').setup({ install_dir = vim.fn.stdpath('data') .. '/site' })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter.setup', {}),
            callback = function(args)
                local buf = args.buf
                local filetype = args.match

                -- you need some mechanism to avoid running on buffers that do not
                -- correspond to a language (like oil.nvim buffers), this implementation
                -- checks if a parser exists for the current language
                local language = vim.treesitter.language.get_lang(filetype) or filetype
                if not vim.treesitter.language.add(language) then
                    return
                end

                -- replicate `highlight = { enable = true }`
                vim.treesitter.start(buf, language)

                -- replicate `indent = { enable = true }`
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
})
return M
