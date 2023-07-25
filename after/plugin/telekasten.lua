local has_telekasten, telekasten = pcall(require, "telekasten")
if not has_telekasten then
    return
end

if not pcall(require, "telescope") then
    print("Telekasten: telescope not found")
    return
end

-- test viu binary availability, for images preview
if vim.fn.executable("viu") == 0 then
    print("Telekasten: viu not found, previewing images will not work")
    return
end

-- Function to map keys, with [Telekasten] prefix for description
local map = function(lhs, rhs, desc)
    if desc then
        desc = "[Telekasten] " .. desc
    end
    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

local wiki_home = vim.fn.expand("~/Projects/main/wiki")
if vim.fn.isdirectory(wiki_home) == 0 then
    return
end
telekasten.setup(
    {
        home = wiki_home,
        image_subdir = 'img',
        plug_into_calendar = true,
        template_new_note = wiki_home .. '/' .. 'templates/new_note.md',
        sort = "modified",
        auto_set_filetype = false,
        -- follow_url_fallback = "call jobstart('linkhandler {{url}}')",
        -- dir names for special notes (absolute path or subdir name)
        new_note_filename = "title",
        media_previewer = "viu-previewer",
    }
)

map("<leader>zf", function()
        telekasten.find_notes()
end, "find notes")

map("<leader>z#", telekasten.show_tags, "show tags")

map("<leader>zg", telekasten.search_notes, "search notes")

map("<leader>zi", telekasten.insert_link, "insert link")

map("<leader>zl", telekasten.insert_img_link, "insert image link")

map("<leader>zL", telekasten.paste_img_and_link, "paste image and link")

vim.keymap.set("n", "<leader>zz", function()
    if vim.bo.filetype == "markdown" then
        telekasten.follow_link()
    end
end, { silent = true, desc = "[Telekasten] follow link" })

map("<leader>zn", telekasten.new_note, "create new note")

map("<leader>zN", telekasten.new_templated_note, "create new note from template")

map("<leader>zy", telekasten.yank_notelink, "yank notelink")

map("<leader>zc", telekasten.show_calendar, "show calendar")

vim.keymap.set("n", "<leader>zt", function ()
   telekasten.toggle_todo({onlyTodo=true})
end, { silent = true, desc = "[Telekasten] toggle TODO (only TODO)" })

vim.keymap.set("v", "<leader>zt", function ()
   telekasten.toggle_todo({onlyTodo=true, v=true})
end, { silent = true, desc = "[Telekasten] toggle TODO (only TODO)" })

map("<leader>zT", telekasten.toggle_todo, "toggle TODO")
vim.keymap.set("v", "<leader>zT", function ()
   telekasten.toggle_todo({v=true})
end, { silent = true, desc = "[Telekasten] toggle TODO" })

map("<leader>zb", telekasten.show_backlinks, "show backlinks")

map("<leader>zB", telekasten.find_friends, "find friends")

map("<leader>zp", telekasten.preview_img, "preview image")

map("<leader>zm", telekasten.browse_media, "browse media")

map("<leader>zr", telekasten.rename_note, "rename note")
