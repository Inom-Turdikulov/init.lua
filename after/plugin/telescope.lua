local ok, telescope = pcall(require, "telescope")
if not ok then return end

telescope.setup {
    defaults = {file_ignore_patterns = {"./node_modules"}},
    extensions = {
        media_files = {filetypes = {"png", "webp", "jpg", "jpeg", "svg", "pdf"}},
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
                }
            }
        }
    }
}

local builtin = require("telescope.builtin")

local map = function(lhs, rhs, desc)
    if desc then desc = "[Telescope] " .. desc end

    vim.keymap.set("n", lhs, rhs, {silent = true, desc = desc})
end

-- find telescope builtins
map("<leader>fF", builtin.builtin, "builtins")

map("<leader>fs",
    function() builtin.grep_string({search = vim.fn.input("Grep > ")}); end,
    "grep")

-- Search - [ ] todo items in markdown files, autofill [ ] and press enter
-- map("<leader>fS", function() builtin.grep_string({ search = "- [ ]") end, "todo items")

vim.keymap.set({"n", "i", "v"}, "<M-p>", function()
    if vim.fn.filereadable(".git/HEAD") == 1 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end, {desc = "[Telescope] find files"})

map("<M-P>", builtin.find_files, "Telescope find files")

map("<M-e>", function() builtin.oldfiles({only_cwd = true}) end, "oldfiles")

map("<leader>fk", builtin.keymaps, "keymaps")

map("<leader>fK", builtin.commands, "commands")

map("<leader>fc", builtin.command_history, "commands history")

map("<M-b>", builtin.buffers, "buffers")

-- File browser
if pcall(require, "telescope._extensions.file_browser") then
    telescope.load_extension("file_browser")
end

-- Previewer
if pcall(require, "telescope._extensions.media_files") then
    telescope.load_extension("media_files")
end

-- open file_browser with the path of the current buffer
map("<leader>pV", function()
    require("telescope").extensions.file_browser.file_browser({
        path = vim.fn.expand("%:p:h"),
        select_buffer = true
    })
end, "File Browser")
