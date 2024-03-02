local ok, todo_comments = pcall(require, "todo-comments")
if not ok then
    return
end

todo_comments.setup{
  signs = false,
  keywords = {
    NEXT = { icon = " ", color = "error"},
  },
  highlight = {
    keyword = "fg",
    pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
  },
  gui_style = {
    fg = "BOLD",
    bg = "NONE",
  },
}


local map = function(lhs, rhs, desc)
    if desc then
        desc = "[Todo] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

-- Keybindings, use keywords with table to jump between groups
map("]t", function() require("todo-comments").jump_next() end, "Next todo comment")
map("[t", function() require("todo-comments").jump_prev() end, "Next todo comment")
