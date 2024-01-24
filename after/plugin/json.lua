local ok, jsonpath = pcall(require, "jsonpath")
if not ok then
  return
end

local Personal_Jsonpath = vim.api.nvim_create_augroup("Personal_Jsonpath", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = Personal_Jsonpath,
    pattern = "*",
    callback = function()
        -- show json path in the winbar only if buffer is a json file
        if vim.fn.exists("+winbar") == 1 and vim.bo.filetype == "json" then
            vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
        end
    end
})

-- send json path to clipboard
-- TODO: map only for json files
vim.keymap.set("n", "y<C-p>", function()
  vim.fn.setreg("+", jsonpath.get())
end, {desc = "[JSONPath] copy path"})
