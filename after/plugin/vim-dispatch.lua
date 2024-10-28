if not vim.g.loaded_dispatch then return end

local generalSettingsGroup = vim.api.nvim_create_augroup('Vim Dispatch', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*.lua' },
    callback = function()
        vim.b.dispatch = 'lua %'
    end,
    group = generalSettingsGroup,
})
