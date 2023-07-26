-- Keymaps

-- Function to map keys, with [Telekasten] prefix for description
local map = function(lhs, rhs, desc)
    if desc then
        desc = "[Dashit] " .. desc
    end
    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader>dk", function()
    local input = vim.fn.input("Dasht > ");
    vim.cmd(":Dasht " .. input)
end, "search related docsets")

map("<leader>dK", function()
    local input = vim.fn.input("Dasht! > ");
    vim.cmd(":Dasht! " .. input)
end, "search ALL the docsets")

map("<leader>dw", ":call Dasht(dasht#cursor_search_terms())<Return>", "search related docsets under cursor")

map("<leader>dW", ":call Dasht(dasht#cursor_search_terms(), '!')<Return>", "search ALL the docsets under cursor")

vim.keymap.set("v", "<leader>ds", "y:<C-U>call Dasht(getreg(0))<Return>", {
    silent=true, desc="[Dashit] related docsets for your selected text"})

vim.keymap.set("v", "<leader>dS", "y:<C-U>call Dasht(getreg(0), '!')<Return>",
    {silent=true, desc="[Dashit] related docsets for ALL the docsets"})

-- Specify related docsets for searching
--  When in Python, also search NumPy, SciPy, and Pandas:
vim.cmd[[
let g:dasht_filetype_docsets = {} " filetype => list of docset name regexp
let g:dasht_filetype_docsets['python'] = ['python', '(num|sci)py', 'pandas', 'SQLAlchemy', 'flask']
]]
