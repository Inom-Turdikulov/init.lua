local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    --[[
          Base dependencies
     --]]
    "nvim-lua/plenary.nvim",
    {'ivanesmantovich/xkbswitch.nvim'},
    { "LunarVim/bigfile.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    "folke/which-key.nvim",
    --[[
          Make nvim looking good
     --]]
    "Inom-Turdikulov/alabaster.nvim",
    "tjdevries/express_line.nvim",
    "folke/zen-mode.nvim",

    { "numToStr/Comment.nvim", lazy = false },
    { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    --[[
          Improve core functional
     --]]
    { -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        config = function()
        end,
    },
    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for install instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires special font.
            --  If you already have a Nerd Font, or terminal set up with fallback fonts
            --  you can enable this
            { 'nvim-tree/nvim-web-devicons' }
        }
    },
    {
        "Inom-Turdikulov/telekasten.nvim",
        dependencies = {
            "nvim-telescope/telescope-media-files.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    {
        "ThePrimeagen/harpoon", -- TODO: switch to main branch
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    { "kevinhwang91/nvim-ufo",              dependencies = "kevinhwang91/promise-async" },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    },
    {
        "SuchithSridhar/nvim-treesitter-context", -- TODO: swap to upstream
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    },
    "Darazaki/indent-o-matic",
    "tpope/vim-eunuch",

    --[[
          Better VCS support
     --]]
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim", -- Git decorations
    --[[
          LSP+
     --]]
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    "saadparwaiz1/cmp_luasnip",
                },
            },
            -- {
            --     "Exafunction/codeium.nvim",
            --     dependencies = {
            --         "nvim-lua/plenary.nvim",
            --     },
            -- },
        },
    },
    "barreiroleo/ltex-extra.nvim",

    --[[
          Code quality and documentation
     --]]
    "stevearc/conform.nvim", -- Formatting
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    { "folke/trouble.nvim",   dependencies = { "nvim-tree/nvim-web-devicons" } },
    "sunaku/vim-dasht",

    --[[
          Debugging & Tasks
     --]]
    "mfussenegger/nvim-dap",
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },
    { "mxsdev/nvim-dap-vscode-js",    dependencies = { "mfussenegger/nvim-dap" } },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },

    --[[
          Code execution and test running
     --]]
    {
        "michaelb/sniprun",
        branch = "master",
        build = "sh install.sh",
        -- do 'sh install.sh 1' if you want to force compile locally
        -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter", -- Language specific plugins
            "nvim-neotest/neotest-python",
            "rouge8/neotest-rust",
            "nvim-neotest/neotest-go",
        },
    },

    --[[
          Databases
     --]]
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod",                     lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
    },

    --[[
          Add support additinal syntax and files specific features
     --]]
    "antonk52/markdowny.nvim",
    "Glench/Vim-Jinja2-Syntax",
    "phelipetls/jsonpath.nvim", -- WARNING: this require tresitter which I installed manually (NixOS)
    "jamessan/vim-gnupg",
})

