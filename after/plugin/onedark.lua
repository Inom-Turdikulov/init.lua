local ok, onedark = pcall(require, "onedark")
if not ok then
  return
end

onedark.setup {
    style = 'darker',
    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    transparent = true,
    ending_tildes = true,
    code_style = {
        comments = 'bold',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
    -- redefine an existing color
    colors = {
        bg3 = "#4c324a",
        fg = "#b1b4b9",
        grey = "#717275",
        ending_tildes = "#b1b4b9",
    },
    -- fix ColorColumn transparency
    highlights = {
        CursorLineNR = { fmt = 'bold' },
        ColorColumn = { bg = '#30363f' },
        NonText = { fg = '#3d4249' },
    }
}

onedark.load()
