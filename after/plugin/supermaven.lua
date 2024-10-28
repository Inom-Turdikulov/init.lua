local ok, supermaven = pcall(require, "supermaven-nvim")
if not ok then return end
supermaven.setup({
    color = {
        suggestion_color = "#696969",
        cterm = 244,
    },
    log_level = "off",
    disable_inline_completion = true,
    disable_keymaps = true
})
