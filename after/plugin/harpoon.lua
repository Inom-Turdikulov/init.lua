local ok, harpoon = pcall(require, "harpoon")
if not ok then return end

harpoon:setup({})

local map = function(lhs, rhs, desc)
    if desc then desc = "[Harpoon] " .. desc end

    vim.keymap.set("n", lhs, rhs, {silent = true, desc = desc})
end

map("<leader>a", function() harpoon:list():append() end, "Add File")
map("<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Open harpoon UI")
map("<C-t>", function() harpoon:list():select(1) end, "Navigate to file 1")
map("<C-n>", function() harpoon:list():select(2) end, "Navigate to file 2")
map("<C-M-t>", function() harpoon:list():select(3) end, "Navigate to file 3")
map("<C-M-n>", function() harpoon:list():select(4) end, "Navigate to file 4")

-- Toggle previous & next buffers stored within Harpoon list
map("<C-M-p>", function() harpoon:list():prev() end, "Toggle Next buffer")
map("<C-M-n>", function() harpoon:list():next() end, "Toggle Previous buffer")
