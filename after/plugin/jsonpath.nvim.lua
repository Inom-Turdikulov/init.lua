local ok, jsonpath = pcall(require, "jsonpath")
if not ok then
  print("jsonpath not found!")
  return
end

-- show json path in the winbar
if vim.fn.exists("+winbar") == 1 then
  vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
end

-- send json path to clipboard
-- TODO: map only for json files
vim.keymap.set("n", "y<C-p>", function()
  vim.fn.setreg("+", jsonpath.get())
end, {desc = "[JSONPath] copy path"})
