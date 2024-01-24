local ok, copilot = pcall(require, "copilot")
if not ok then return end

-- I use copilot with copilot-cmp (cmp autocomplete plugin)
-- so suggestion and panel are disabled
-- you need to auth/validate copilot with github on first run
-- `Copilot auth` or `Copilot status`
copilot.setup({
    suggestion = {enabled = false},
    panel = {enabled = false},
    filetypes = {
        gitcommit = true,
        yaml = true,
        markdown = true,
        python = true,
        javascript = true,
        html = true,
        jinja = true,
        css = true,
        scss = true,
        lua = true,
        c = true,
        cpp = true,
        rust = true,
        json = true,
        nix = true,
        bash = true,
        zsh = true,
        sh = function()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)),
                            '^%.env.*') then
                -- disable for .env files
                return false
            end
            return true
        end,
        ["*"] = false -- disable for all other filetypes and ignore default `filetypes`
    }
})

-- Toggle Copilot
vim.keymap.set("", "<M-\\>", ":Copilot toggle<CR>",
               {silent = true, desc = "[Copilot] Toggle"})
