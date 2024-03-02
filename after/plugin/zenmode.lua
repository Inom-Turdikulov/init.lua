-- Only text
vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = 80,
            options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,
                colorcolumn = "0",
                wrap = false,
                list = false, -- disable whitespace characters
            },
        },
    }
    require("zen-mode").toggle()
end)

-- Hide line numbers and colorcolumn
vim.keymap.set("n", "<leader>zZ", function()
    require("zen-mode").setup {
        window = {
            width = 80,
            options = {
                number = false,
                relativenumber = false,
                colorcolumn = "0",
            }
        },
    }
    require("zen-mode").toggle()
end)
