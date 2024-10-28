local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

local builtin = require("telescope.builtin")

local map = function(lhs, rhs, desc)
    if desc then
        desc = "[Telescope] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

telescope.setup({
    defaults = {
        file_ignore_patterns = { "./node_modules" },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
        media_files = {
            filetypes = { "png", "jpg", "gif", "mp4", "webm", "webp", "pdf" },
            find_cmd = "find",
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
})

-- Enable telescope extensions, if they are installed
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")
pcall(telescope.load_extension, "media_files")

-- find telescope builtins
map("<leader>fb", builtin.buffers, "buffers")

map('<leader>ff', builtin.find_files, "[F]ind [F]iles")

map('<M-f>', function()
    if vim.fn.filereadable(".git/HEAD") == 1 then
        builtin.git_files()
    else
        vim.notify("Not a git repository", "error")
    end
end, "Git files")

map("<leader>fs", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, "grep")

map("<M-e>", function()
    builtin.oldfiles({ only_cwd = true })
end, "oldfiles")

map('<leader>fh', builtin.help_tags, "Help tags")

map("<leader>fk", function ()
    builtin.keymaps({ show_plug = false })
end , "keymaps")

map("<leader>fK", builtin.commands, "commands")

map("<leader>fc", builtin.command_history, "commands history")

-- Shortcut for searching your neovim configuration files
map("<leader>vpP", function()
    builtin.find_files({
        cwd = vim.fn.stdpath("config"),
    })
end, "neovim files")
