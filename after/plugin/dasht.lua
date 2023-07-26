-- Keymaps

-- search related docsets
vim.keymap.set("n", "<leader>dk", ":Dasht<space>")

-- search ALL the docsets
vim.keymap.set("n", "<leader>dK", ":Dasht!<space>")

-- search related docsets under cursor
vim.keymap.set("n", "<leader>dw", ":call Dasht(dasht#cursor_search_terms())<Return>")

-- search ALL the docsets under cursor
vim.keymap.set("n", "<leader>dW", ":call Dasht(dasht#cursor_search_terms(), '!'")

-- related docsets for your selected text
vim.keymap.set("v", "<leader>ds", "y:<C-U>call Dasht(getreg(0))<Return>")

-- related docsets for ALL the docsets
vim.keymap.set("v", "<leader>dS", "y:<C-U>call Dasht(getreg(0), '!')<Return>")

-- Specify related docsets for searching
--  When in Python, also search NumPy, SciPy, and Pandas:
vim.cmd[[
let g:dasht_filetype_docsets['python'] = ['python', '(num|sci)py', 'pandas']
]]
