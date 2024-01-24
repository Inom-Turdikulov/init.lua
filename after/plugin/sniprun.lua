local ok, sniprun = pcall(require, "sniprun")
if not ok then return end

sniprun.setup({
    interpreter_options = {
        C_original = {compiler = "gcc"},
        Python3_original = {interpreter = "python3"}
    }
})

-- Select block by viB or vaB, and run SnipRun by f key
vim.api.nvim_set_keymap('v', 'f', '<Plug>SnipRun',
                        {silent = true, desc = "[SnipRun] Run selection"})
vim.api.nvim_set_keymap('n', '<leader>ze', '<Plug>SnipRunOperator',
                        {silent = true, desc = "[SnipRun] Run Operator"})
vim.api.nvim_set_keymap('n', '<leader>zee', '<Plug>SnipRun',
                        {silent = true, desc = "[SnipRun] Run"})
