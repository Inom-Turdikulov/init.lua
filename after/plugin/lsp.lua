--[[
  setup is based on this blogpost:
  https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
]]
-- Test plugins exists
local plugins = { "lspconfig", "cmp", "cmp_nvim_lsp", "luasnip", "codeium" }

for _, plugin in ipairs(plugins) do
    local ok, _ = pcall(require, plugin)
    if not ok then
        return
    end
end

---
-- Reduce floating window size
---
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "single"
    opts.max_width = opts.max_width or 80
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

---
-- Keybindings
---
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function()
        local map = function(lhs, rhs, desc)
            if desc then
                desc = "[LSP] " .. desc
            end

            vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
        end

        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
        map("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "Lis workspace folders")

        map("K", vim.lsp.buf.hover, "hover")
        map("gd", vim.lsp.buf.definition, "go to definition")
        map("gD", vim.lsp.buf.declaration, "go to declaration")
        map("gi", vim.lsp.buf.implementation, "go to implementation")

        -- Formatting
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, { silent = true, desc = "format" })

        map("go", vim.lsp.buf.type_definition, "go to type definition")
        map("gr", vim.lsp.buf.references, "go to references")

        -- NOTE: this keymap for xst/st term, in our case Ctrl-F1
        vim.keymap.set("i", "<F25>", function()
            vim.lsp.buf.signature_help()
        end, { desc = "[LSP] signature Help" })

        map("<leader>vrn", vim.lsp.buf.rename, "rename")
        map("<leader>vaa", vim.lsp.buf.code_action, "code action")
        vim.keymap.set("x", "<leader>vaa", function()
            vim.lsp.buf.range_code_action()
        end, { silent = true, desc = "[LSP] Range Code Action" })

        -- Diagnostic
        map("gl", vim.diagnostic.open_float, "hover diagnostic")
        map("[d", vim.diagnostic.goto_prev, "go to previous diagnostic")
        map("]d", vim.diagnostic.goto_next, "go to next diagnostic")

        -- Symbols
        map("<leader>vws", function()
            vim.cmd("Telescope lsp_dynamic_workspace_symbols")
        end, "telescope workspace symbol")

        map("<leader>vwS", vim.lsp.buf.workspace_symbol, "workspace Symbol")
    end,
})

---
-- Diagnostics
---

local sign = function(opts)
    vim.fn.sign_define(opts.name, { texthl = opts.name, text = opts.text, numhl = "" })
end

sign({ name = "DiagnosticSignError", text = "E" })
sign({ name = "DiagnosticSignWarn", text = "W" })
sign({ name = "DiagnosticSignHint", text = "?" })
sign({ name = "DiagnosticSignInfo", text = "I" })
sign({ name = "CmpItemKindCopilot", text = "" })

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded", source = "always" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

---
-- LSP config
---

-- require('mason').setup({})
-- require('mason-lspconfig').setup({})
require("codeium").setup({
    tools = {
        language_server = vim.fn.exepath("codeium-lsp")
    }
})

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lsp_defaults.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
    -- require('copilot_cmp').default_capabilities())
)

---
-- LSP servers
---

local function on_attach(client, bufnr)
    local augroup = vim.api.nvim_create_augroup
    if vim.env.NVIM_AUTOFORMAT == "1" and client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

lspconfig.tsserver.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
        },
    },
})
lspconfig.pyright.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })
lspconfig.rust_analyzer.setup({ on_attach = on_attach })
lspconfig.gdscript.setup({})
lspconfig.emmet_ls.setup({
    filetypes = { "html", "typescript", "jinja", "css", "scss" },
})
-- lspconfig.ruff_lsp.setup {}
-- lspconfig.nil_ls.setup {}

local efmls_loaded, efmls = pcall(require, "efmls-configs")
if efmls_loaded then
    local eslint_d = require("efmls-configs.linters.eslint_d")
    local prettier = require("efmls-configs.formatters.prettier_d")

    local stylua = require("efmls-configs.formatters.stylua")
    local ruff_formatter = require("efmls-configs.formatters.ruff")
    local ruff_linter = require("efmls-configs.linters.ruff")

    local languages = {
        -- markdown = {prettier},
        javascript = { eslint_d, prettier },
        lua = { stylua },
        python = { ruff_linter, ruff_formatter },
        yaml = { prettier },
        json = { prettier },
        html = { prettier },
        scss = { prettier },
        css = { prettier },
        gdscript = { { formatCommand = "gdformat -s 4 -", formatStdin = true } },
    }

    local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = { rootMarkers = { ".git/" }, languages = languages },
        init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
        },
    }

    lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {}))
end

local ok, ltex_extra = pcall(require, "ltex_extra")
if ok then
    local ltex_filetypes = { "markdown", "tex", "bib", "rst" }

    lspconfig.ltex.setup({
        on_attach = function(client, bufnr)
            -- If buffer is netrw do not load lsp
            ltex_extra.setup({
                load_langs = { "ru-RU", "en-US", "fr" }, -- table <string> : languages for witch dictionaries will be loaded
                init_check = true, -- boolean : whether to load dictionaries on startup
                path = vim.fn.stdpath("config") .. "/spell", -- string : path to store dictionaries. Relative path uses current working directory
                log_level = "none", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
            })
        end,
        settings = {
            ltex = {
                -- check LSP config if you add new filetypes
                filetypes = ltex_filetypes,
            },
        },
    })
end

---
-- Autocomplete
---
vim.opt.completeopt = { "menu", "menuone", "noselect" }

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load({
    paths = { vim.fn.stdpath("config") .. "/snippets" },
})

local cmp = require("cmp")
local luasnip = require("luasnip")

local select_opts = { behavior = cmp.SelectBehavior.Select }

local timer = nil
vim.api.nvim_create_autocmd({ "TextChangedI", "CmdlineChanged" }, {
    pattern = "*",
    callback = function()
        if timer then
            vim.loop.timer_stop(timer)
            timer = nil
        end

        timer = vim.loop.new_timer()
        timer:start(
            600,
            0,
            vim.schedule_wrap(function()
                require("cmp").complete({ reason = require("cmp").ContextReason.Auto })
            end)
        )
    end,
})

cmp.setup({
    completion = {
        autocomplete = false,
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp", group_index = 2, keyword_length = 1 },
        { name = "path", group_index = 2, keyword_length = 1 },
        { name = "luasnip", group_index = 2, keyword_length = 2 },
        { name = "buffer", group_index = 2, keyword_length = 3 },
        { name = "codeium", group_index = 2, priority = -10000 },
    },
    window = { documentation = cmp.config.window.bordered() },
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = "λ",
                luasnip = "⋗",
                buffer = "Ω",
                path = "🖫",
            }

            item.menu = menu_icon[entry.source.name]
            item.abbr = string.sub(item.abbr, 1, 80)
            return item
        end,
    },
    mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
        ["<Down>"] = cmp.mapping.select_next_item(select_opts),

        ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
        ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),

        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<C-f>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        -- If the completion menu is visible, move to the next item. If the
        -- line is "empty", insert a Tab character.
        -- If the cursor is inside a word, trigger the completion menu.
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),

        -- If the completion menu is visible, move to the previous item.
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
})
