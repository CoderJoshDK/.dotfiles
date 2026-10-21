vim.keymap.set({ 'n', 'i' }, '<M-s>', function()
        -- Enabling/disabling a server affects every Python buffer in this session.
        if vim.lsp.is_enabled('basedpyright') then
            vim.lsp.enable('basedpyright', false)
            vim.lsp.enable('ty', true)
            vim.notify("Switching to ty")
        else
            vim.lsp.enable('ty', false)
            vim.lsp.enable('basedpyright', true)
            vim.notify("Switching to basedpyright")
        end
        -- Reload to clear stale diagnostics and refresh them with the new server.
        vim.cmd.edit()
    end,
    { buffer = true, desc = 'Swap Python LSP between basedpyright and ty (session-wide)' }
)

vim.b.undo_ftplugin = (vim.b.undo_ftplugin and (vim.b.undo_ftplugin .. ' | ') or '')
    .. "execute 'silent! nunmap <buffer> <M-s>' | execute 'silent! iunmap <buffer> <M-s>'"
