local ok, mdeval = pcall(require, "mdeval")
if not ok then return end

mdeval.setup({
  require_confirmation=false,
  eval_options = {
    cpp = {
      command = {"clang++", "-std=c++20", "-O0"},
      default_header = [[
    #include <iostream>
    #include <vector>
    using namespace std;
      ]]
    },
    go = {
      command = {"go", "run"},  -- Command to run go compiler
      language_code = "go",    -- Markdown language code
      exec_type = "interpreted",  -- compiled or interpreted
      extension = "go",        -- File extension for temporary files
    },
  },
})

-- Select block by viB or vaB, and run SnipRun by f key
vim.api.nvim_set_keymap('n', '<leader>ve', "<cmd>lua require 'mdeval'.eval_code_block()<CR>", {silent = true, desc = "[mdeval] Run selection"})

