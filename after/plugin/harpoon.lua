local ok, harpoon = pcall(require, "harpoon")
if not ok then
    return
end

harpoon:setup({
  settings = {
    save_on_toggle = true,
  },
})

local map = function(lhs, rhs, desc)
    if desc then
        desc = "[Harpoon] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader>a", function()
    harpoon:list():add()
end, "Add File")

map("<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, "Open harpoon UI")

local bindings = { 't', 'g', 'm', 'n'  }
for k,v in pairs(bindings) do
  map("<C-" .. v .. ">", function() harpoon:list():select(k) end, "Navigate to file " .. k)
end

-- Toggle previous & next buffers stored within Harpoon list
map("<C-M-P>", function()
    harpoon:list():next()
end, "Toggle Previous buffer")

map("<C-M-N>", function()
    harpoon:list():prev()
end, "Toggle Next buffer")
