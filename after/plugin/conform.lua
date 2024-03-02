local ok, conform = pcall(require, "conform")
if not ok then
    return
end

conform.setup({
    formatters_by_ft = {
        nix = { "nixpkgs_fmt" },
        python = { "ruff_fix", "ruff_format" },
        go = { "goimports", "gofmt" },
        markdown = { "deno_fmt" },
        javascript = { "deno_fmt" },
        typescript = { "deno_fmt" },
        json = { "deno_fmt" },
        yaml = { "prettierd" },
        html = { "prettierd" },
        scss = { "prettierd" },
        css = { "prettierd" },
        gdscript = { "gdformat" },
    },
})

vim.keymap.set({ "n", "x" }, "<leader>=", function()
    conform.format({
        async = true,
        lsp_fallback = true
    })
end, { silent = true, desc = "[Conform] format" })
