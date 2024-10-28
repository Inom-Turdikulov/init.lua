if not vim.g.loaded_dispatch then return end

local generalSettingsGroup = vim.api.nvim_create_augroup('Vim Dispatch', { clear = true })

local default_dispatch_per_files = {
    python = 'python %',
    lua = 'lua %',
    sh = 'sh %',
}

for key, value in pairs(default_dispatch_per_files) do
    vim.api.nvim_create_autocmd('FileType', {
        pattern = key,
        callback = function()
            vim.b.dispatch = value
        end,
        group = generalSettingsGroup,
    })
end
