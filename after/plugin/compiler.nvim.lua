if not pcall(require, "overseer") or not pcall(require, "compiler") then
  return
end

require('overseer').setup({
    task_list = {
      direction = "bottom",
      min_height = 12,
      max_height = 12,
      default_detail = 1,
      bindings = { ["q"] = function() vim.cmd("OverseerClose") end },
    }
})
require('compiler').setup()

local map = function(lhs, rhs, desc)
    if desc then
        desc = "[Compiler] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader>el", "<cmd>CompilerOpen<cr>", "open compiler")

map("<leader>ee", function()
  vim.cmd("CompilerStop") -- (Optional, to dispose all tasks before redo)
  vim.cmd("CompilerRedo")
end, "redo last selected option")

map('<leader>et', "<cmd>CompilerToggleResults<cr>", "toggle compiler results")
