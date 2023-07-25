local ok, signs = pcall(require, "gitsigns")
if not ok then
  return
end

signs.setup {
  -- Highlights just the number part of the number column
  numhl = true,

  -- Highlights the _whole_ line.
  --    Instead, use gitsigns.toggle_linehl()
  linehl = false,

  -- Highlights just the part of the line that has changed
  --    Instead, use gitsigns.toggle_word_diff()
  word_diff = false,

  -- TODO: Figure out what the new thing is for keymaps and git signs
  -- TODO: use onattach! onattach = function(bufnr) ... end
  -- keymaps = {
  --   -- Default keymap options
  --   noremap = true,
  --   buffer = true,
  --
  --   ["n <space>hd"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
  --   ["n <space>hu"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
  --
  --   -- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
  --   -- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
  --   -- ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  --   -- ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  --   -- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  -- },

  current_line_blame_opts = {
    delay = 2000,
    virt_text_pos = "eol",
  },
}

-- TODO: decide mappings for this
-- local nnoremap = vim.keymap.nnoremap
-- nnoremap { "<space>tsw", signs.toggle_word_diff }
-- nnoremap { "<space>tsh", signs.toggle_word_diff }
