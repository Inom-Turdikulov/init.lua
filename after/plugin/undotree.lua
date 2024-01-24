if not vim.g.loaded_undotree then return end

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
