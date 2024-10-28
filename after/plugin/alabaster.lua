vim.cmd("colorscheme alabaster")

-- Customize theme
vim.api.nvim_set_hl(0,'ColorColumn',{ bg='#30363f'})
vim.api.nvim_set_hl(0,'CopilotAnnotation',{ fg='#9d9c9c'})
vim.api.nvim_set_hl(0,'CopilotSuggestion',{ fg='#9d9c9c'})
-- Visual selection
vim.api.nvim_set_hl(0,'Visual',{ bg = '#333444'})

-- Express line
vim.api.nvim_set_hl(0,'ElInsert',{ fg='white', bg='green'})

-- Transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg='NONE'})
vim.api.nvim_set_hl(0, 'NonText', { bg='NONE', fg='#444a52'})
