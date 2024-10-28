local ok, conform = pcall(require, "conform")
if not ok then
    return
end

conform.setup({
    formatters_by_ft = {
        nix             = { "nixpkgs_fmt" },
        python          = { "ruff_fix", "ruff_format" },
        go              = { "goimports", "gofmt" },
        markdown        = { "deno_fmt" },
        javascript      = { "biome" },
        typescript      = { "biome" },
        typescriptreact = { "biome" },
        json            = { "biome" },
        jsonc           = { "biome" },
        yaml            = { "prettierd" },
        html            = { "prettierd" },
        scss            = { "prettierd" },
        css             = { "prettierd" },
        gdscript        = { "gdformat" },
        jinja           = { "djlint" },
        sql             = { "sqlfluff" },
        bash            = { "shfmt" },
    }
})

vim.keymap.set({ "n", "x" }, "<leader>=", function()
    conform.format({
        async = true,
        lsp_fallback = true
    })
end, { silent = true, desc = "[Conform] format" })
