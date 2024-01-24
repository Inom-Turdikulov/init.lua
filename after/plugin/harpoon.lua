local ok, harpoon = pcall(require, "harpoon")
if not ok then return end

harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({results = file_paths}),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({})
    }):find()
end

local map = function(lhs, rhs, desc)
    if desc then desc = "[Harpoon] " .. desc end

    vim.keymap.set("n", lhs, rhs, {silent = true, desc = desc})
end

map("<leader>a", function() harpoon:list():append() end, "Add File")
map("<C-e>", function() toggle_telescope(harpoon:list()) end,
    "Open harpoon window")
map("<C-t>", function() harpoon:list():select(1) end, "Navigate to file 1")
map("<C-n>", function() harpoon:list():select(2) end, "Navigate to file 2")
map("<C-M-t>", function() harpoon:list():select(3) end, "Navigate to file 3")
map("<C-M-n>", function() harpoon:list():select(4) end, "Navigate to file 4")

-- Toggle previous & next buffers stored within Harpoon list
map("<C-M-p>", function() harpoon:list():prev() end, "Toggle Next buffer")
map("<C-M-n>", function() harpoon:list():next() end, "Toggle Previous buffer")
