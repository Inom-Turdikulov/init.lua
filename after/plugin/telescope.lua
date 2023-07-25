local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local builtin = require('telescope.builtin')

-- find telescope builtins
vim.keymap.set("n", "<leader>fF", function()
    builtin.builtin()
end, { noremap = true, silent = true }, { desc = 'Telescope builtins' })

vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- Search - [ ] todo items in markdown files, autofill [ ] and press enter
vim.keymap.set('n', '<leader>fS', function()
    builtin.grep_string({ search = '- [ ]' });
end)

vim.keymap.set("n", "<M-e>", function()
    builtin.oldfiles({ only_cwd = true })
end, { noremap = true, silent = true }, { desc = 'Telescope oldfiles' })

vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })

vim.keymap.set('n', '<leader>fK', builtin.commands, { desc = 'Commands' })

vim.keymap.set('n', '<leader>fc', builtin.command_history,
    { desc = 'Command history' })

vim.keymap.set({ "n", "i", "v" }, '<M-p>', function()
    if vim.fn.filereadable('.git/HEAD') == 1 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end, { desc = 'Telescope find files' })

vim.keymap.set('n', '<M-P>', function()
    builtin.resume()
end, { desc = 'Telescope resume' })

vim.keymap.set('n', '<M-b>', function()
    builtin.buffers()
end, { desc = 'Telescope buffers' })

telescope.setup {
    defaults = {
        file_ignore_patterns = {
            "./node_modules",
        },
    },
    extensions = {
        media_files = {
            find_cmd = "fd"
        },
        file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = false,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
}

-- File browser
if not pcall(require, "telescope._extensions.file_browser") then
    print("file_browser not found")
    return
end

telescope.load_extension("file_browser")

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<leader>pV", function()
    require("telescope").extensions.file_browser.file_browser({
        path = vim.fn.expand("%:p:h"),
        select_buffer = true,
    })
end, {})
