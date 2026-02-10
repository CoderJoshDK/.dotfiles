return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    -- Everything in opts will be passed to setup()
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Full list with :help conform-formatters
        -- Define your formatters
        formatters_by_ft = {
            -- lua = { "stylua" },
            json = { "jq", "prettierd", "prettier", stop_after_first = true },
            python = { "ruff_organize_imports", "ruff_format" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            markdown = { "markdownlint", "markdownlint-cli2", stop_after_first = true },
            rust = { "rustfmt", lsp_format = "fallback", args = { "+nightly" } },
            ruby = { "rubocop_internal", "rubocop", stop_after_first = true },
            eruby = { lsp_format = "fallback" },
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 1000, lsp_format = "fallback" }, -- Customize formatters
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
