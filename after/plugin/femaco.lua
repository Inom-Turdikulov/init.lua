local ok, femaco = pcall(require, "femaco")
if not ok then return end

femaco.setup {
    ft_from_lang = function(lang)
        Language = lang
        return lang
    end,
    -- what to do after opening the float
    post_open_float = function(winnr)
        if Language == "js" then
            vim.cmd("setlocal filetype=javascript")
        end
    end
}

vim.keymap.set("n", "<Leader>vv", require('femaco.edit').edit_code_block, { desc = "[Femaco] edit code block" })
