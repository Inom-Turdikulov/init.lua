local function escape(str)
    -- You need to escape these characters to work correctly
    local escape_chars = [[;,."|\]]
    return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[jk`qwertyuiop[]asdfghl;'zxcvbnm/]]
local ru = [[нтёйцлыащшджкхъфвсупьгзэиячмеор.]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:ZXCVBNM<>]]
local ru_shift = [[ЁЙЦЛВАЩШДЖКХЪФВСУПЬНТГЗИЯЧМЕОРБЮ]]

vim.opt.langmap = vim.fn.join({
    -- | `to` should be first     | `from` should be second
    escape(ru_shift)
    .. ";"
    .. escape(en_shift),
    escape(ru) .. ";" .. escape(en),
}, ",")
