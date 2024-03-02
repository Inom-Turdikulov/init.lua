local map = function(lhs, rhs, desc)
    if desc then desc = "[DB] " .. desc end

    vim.keymap.set("n", lhs, rhs, {silent = true, desc = desc})
end

vim.g.db_ui_use_nerd_fonts = 1

map("<leader>qt", ":DBUI<CR>", "toggle dadbod UI")
map("<leader>qi", ":DBUILastQueryInfo<CR>", "last query info")
