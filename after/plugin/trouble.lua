local ok, trouble = pcall(require, "trouble")
if not ok then return end

trouble.setup {}
local map = function(lhs, rhs, desc)
    if desc then desc = "[Trouble] " .. desc end

    vim.keymap.set("n", lhs, rhs, {silent = true, desc = desc})
end

map("<leader>xx", function() require("trouble").toggle() end,
    "Toggle")
map("<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
    "Workspace Diagnostics")
map("<leader>xd",
    function() require("trouble").toggle("document_diagnostics") end,
    "Document Diagnostics")
map("<leader>xq", function() require("trouble").toggle("quickfix") end,
    "QuickFix")
map("<leader>xl", function() require("trouble").toggle("loclist") end,
    "LocList")
map("gR", function() require("trouble").toggle("lsp_references") end,
    "LSP references")
