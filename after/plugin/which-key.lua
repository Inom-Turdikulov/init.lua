local ok, whichKey = pcall(require, "which-key")
if not ok then
  return
end

whichKey.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    icons = {
        breadcrumb = ">>", -- symbol used in the command line area that shows your active key combo
        separator = ">", -- symbol used between a key and it's label
        group = "+",  -- symbol prepended to a group
    },
}
