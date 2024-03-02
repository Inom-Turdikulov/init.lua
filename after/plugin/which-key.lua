local ok, which_key = pcall(require, "which-key")
if not ok then return end

which_key.setup {
    icons = {
        breadcrumb = ">>", -- symbol used in the command line area that shows your active key combo
        separator = ">", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    }
}
