-- WARNING this file can be outdated, since I use my own nixos configuration
-- and it's not included in init.lua configuration
-- to use it need install packer, load file (`so %`) and run `:PackerSync`
-- actual plugins are here: https://github.com/Inom-Turdikulov/nix_dotfiles/blob/master/modules/editors/vim.nix

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Universal plugins, with minimum requirements
    -- ===============================
    use 'Darazaki/indent-o-matic'

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }

    use { "phelipetls/jsonpath.nvim" }

    use { "tpope/vim-rsi"}

    use { "jamessan/vim-gnupg" }

    -- required pynvim
    use { "jalvesaq/zotcite" }
    use { "jalvesaq/cmp-zotcite" }

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Sort of lua framework
    use { 'nvim-lua/plenary.nvim' }

    -- File finder
    use {
       'nvim-telescope/telescope.nvim', tag = '0.1.1',
       -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- File browser
    use {
        "nvim-telescope/telescope-file-browser.nvim",
         requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim",
             "nvim-tree/nvim-web-devicons" }
    }

    -- Image viewer
    use {
        "nvim-telescope/telescope-media-files.nvim",
         requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim",
             "nvim-telescope/telescope.nvim" }
    }

    -- A dark Vim/Neovim color scheme for the GUI and 16/256/true-color terminal
    use 'navarasu/onedark.nvim'

    -- Pretty tabs
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}

    -- Syntax Highlighiting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground' }

    -- Shows the context of the currently visible buffer content
    -- like pin header of current article, or like sticky header of table
    use { 'nvim-treesitter/nvim-treesitter-context' }

    -- Harpoon
    use {
        'ThePrimeagen/harpoon',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- enchance locations lists
    use {
        "cbochs/portal.nvim",
        -- Optional dependencies
        requires = {
            "cbochs/grapple.nvim",
            "ThePrimeagen/harpoon"
        },
    }

    -- Tree sitter text objects
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    -- Undo tree
    use('mbbill/undotree')

    -- GIT
    use('tpope/vim-fugitive')
    use('tpope/vim-rhubarb') -- Fugitive-companion to interact with github
    use('idanarye/vim-merginal')
    -- maybe not needed?
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }

    -- Distraction-free coding
    use("folke/zen-mode.nvim")

    -- Local vimrc support
    use('klen/nvim-config-local')

    -- Editor config support
    use('gpanders/editorconfig.nvim')

    -- Commenting plugin
    use {
         'numToStr/Comment.nvim',
    }

    -- TODO plugin
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    -- Shortcuts helper
    use {
        "folke/which-key.nvim"
    }

    -- Surrond objects
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    })

    -- Statusline
    use { "tjdevries/express_line.nvim" }

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- Fix ltex (lsp spell checker) issuse
            { "barreiroleo/ltex-extra.nvim" },

            -- Fix efm configuraton
            { "creativenull/efmls-configs-nvim" }
        }
    }

    -- OpenAI Codex to suggest code and entire functions
    use { "zbirenbaum/copilot.lua" }
    use { "zbirenbaum/copilot-cmp" }
    use { "sunaku/vim-dasht" }

    -- External documentation using zeal
    use("KabbAmine/zeavim.vim")

    -- Linux (my main OS) specific plugins
    -- ===============================
    local os_name = vim.loop.os_uname().sysname
    if os_name == 'Linux' then
        -- Soft/hard wrap modes
        use { 'andrewferrier/wrapping.nvim' }

        -- Diagnostic
        use({
            "folke/trouble.nvim"
        })

        -- Fun and useless animations
        use("eandrju/cellular-automaton.nvim")

        -- Hex editor
        use("RaafatTurki/hex.nvim")

        -- Debugging
        use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
        use { "theHamsta/nvim-dap-virtual-text" }
        use { "nvim-telescope/telescope-dap.nvim" }
        use {'Weissle/persistent-breakpoints.nvim'}
        use {
            'mfussenegger/nvim-dap-python',
            requires = { { 'mfussenegger/nvim-dap' } }
        }
        use { "mxsdev/nvim-dap-vscode-js", -- js debugging
            requires = { "mfussenegger/nvim-dap" }
        }

        -- Testing
        use {
            "nvim-neotest/neotest",
            requires = {
                "nvim-neotest/neotest-python",
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "antoinemadec/FixCursorHold.nvim"
            }
        }

        -- Telekasten - zettelkasten wiki
        use('renerocksai/telekasten.nvim')

        -- Obsidian integration
        use('epwalsh/obsidian.nvim')

        -- Markdown preview
        use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })

        -- Bibtex integration
        use({
            "jghauser/papis.nvim",
            after = { "telescope.nvim", "nvim-cmp" },
            requires = {
                "kkharji/sqlite.lua",
                "nvim-lua/plenary.nvim",
                "MunifTanjim/nui.nvim",
                "nvim-treesitter/nvim-treesitter",
            },
        })

        -- Execute code blocks in markdown
        use { "michaelb/sniprun", run = "bash install.sh" }

        -- Super formatter for markdown
        use {
            'antonk52/markdowny.nvim',
        }

        -- Bullet points for markdown
        use 'dkarter/bullets.vim'

        -- Jupyter notebook integration
        use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

        -- Transaltion
        use("uga-rosa/translate.nvim")

        -- Calendar
        use("mattn/calendar-vim")

        -- interacting with databases, sql client
        use { "tpope/vim-dadbod" }
        use { "kristijanhusak/vim-dadbod-ui" }
        use { "kristijanhusak/vim-dadbod-completion" }

        -- Refactoring
        use({
            'python-rope/ropevim',
            ft = "python"
        })

        -- jinja2 support
        use { "Glench/Vim-Jinja2-Syntax" }

        -- Code folding
        use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

        -- Open/save file as sudo
        -- possible to remove when this can be fixed https://github.com/neovim/neovim/issues/1496
        use {
            'lambdalisue/suda.vim'
        }

        use {
            'direnv/direnv.vim'
        }
    end
end)
