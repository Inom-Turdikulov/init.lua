local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Core dependencies
    "nvim-lua/plenary.nvim",
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

    -- Make nvim looking good
    "navarasu/onedark.nvim", "nvim-tree/nvim-web-devicons",
    "tjdevries/express_line.nvim", -- Improve core functional
    {"numToStr/Comment.nvim", lazy = false}, "folke/which-key.nvim",

    "nvim-telescope/telescope.nvim", {
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = {
            "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-file-browser.nvim"
        }
    }, "tpope/vim-rsi", {
        "ThePrimeagen/harpoon", -- TODO: switch to main branch
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"
        }
    }, "cbochs/portal.nvim", -- has harpoon as optional dependency
    {"kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async"}, {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy"
    }, {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter"
    }, -- Better VCS support
    "mbbill/undotree", "tpope/vim-fugitive", -- Telekasten & Telescope
    {
        "renerocksai/telekasten.nvim",
        dependencies = {"nvim-telescope/telescope.nvim"}
    }, -- LSP
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip"
                }
            },
            {
                "zbirenbaum/copilot-cmp",
                dependencies = {"zbirenbaum/copilot.lua"}
            }
        }
    }, "barreiroleo/ltex-extra.nvim", {
        "creativenull/efmls-configs-nvim",
        version = "v1.x.x", -- version is optional, but recommended
        dependencies = {"neovim/nvim-lspconfig"}
    }, -- Code quality and documentation
    --[[
         Code quality and documentation
    --]]
    "stevearc/conform.nvim", -- Formatting
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter"
        }
    }, {"folke/trouble.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}},
    "sunaku/vim-dasht", -- Debugging
    "mfussenegger/nvim-dap",
    {"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}}, {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"
        }
    },
    {"mfussenegger/nvim-dap-python", dependencies = {"mfussenegger/nvim-dap"}},
    {"mxsdev/nvim-dap-vscode-js", dependencies = {"mfussenegger/nvim-dap"}}, {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter"
        }
    }, -- Code execution and test running
    {
        "michaelb/sniprun",
        branch = "master",
        build = "sh install.sh"
        -- do 'sh install.sh 1' if you want to force compile locally
        -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    }, {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter", -- Language specific plugins
            "nvim-neotest/neotest-python", "rouge8/neotest-rust",
            "nvim-neotest/neotest-go"
        }
    }, -- Add support additinal syntax and files specific actions
    "antonk52/markdowny.nvim", "Glench/Vim-Jinja2-Syntax",
    "phelipetls/jsonpath.nvim", -- WARNING: this require tresitter which I installed manually (NixOS)
    "jamessan/vim-gnupg"
})
