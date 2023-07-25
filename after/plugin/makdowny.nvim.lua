if not pcall(require, "markdowny") then
  return
end

vim.api.nvim_create_autocmd('FileType', {
    desc = 'markdowny.nvim keymaps',
    pattern = { 'markdown' },
    callback = function()
        vim.keymap.set('v', '<C-b>', ":lua require('markdowny').bold()<cr>", { buffer = 0 })
        vim.keymap.set('v', '<C-i>', ":lua require('markdowny').italic()<cr>", { buffer = 0 })
        vim.keymap.set('v', '<C-k>', ":lua require('markdowny').link()<cr>", { buffer = 0 })
        vim.keymap.set('v', '<C-e>', ":lua require('markdowny').code()<cr>", { buffer = 0 })
    end,
})
