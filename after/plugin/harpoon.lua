local ok, harpoon = pcall(require, "harpoon")
if not ok then
    return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local map = function(lhs, rhs, desc)
    if desc then desc = "[Harpoon] " .. desc end

    vim.keymap.set("n", lhs, rhs, {silent = true, desc = desc})
end


map("<leader>a", mark.add_file, "add file")
map("<C-e>", ui.toggle_quick_menu, "menu")

map("<C-t>", function() ui.nav_file(1) end, "navigate to file 1")
map("<C-n>", function() ui.nav_file(2) end, "navigate to file 2")
map("<C-M-t>", function() ui.nav_file(3) end, "navigate to file 3")
map("<C-M-n>", function() ui.nav_file(4) end, "navigate to file 4")

map("<C-Bslash>", function() require("harpoon.term").gotoTerminal(1) end,
    "navigate to terminal 1")
map("<C-M-Bslash>", function() require("harpoon.term").gotoTerminal(2) end,
    "navigate to terminal 2")
map("<C-return>", function() require("harpoon.term").gotoTerminal(3) end,
    "navigate to terminal 3")
map("<C-M-return>", function() require("harpoon.term").gotoTerminal(4) end,
    "navigate to terminal 4")

harpoon.setup({
    -- Yes $HOME works
    projects = {
        ["$HOME/Projects/main/wiki"] = {
            term = {
                cmds = {
                    "./deploy.sh<cr>"
                }
            }
        }
    }
})
