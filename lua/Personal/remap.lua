local vim_config_dir = vim.fn.stdpath("config")
vim.g.mapleader = " " -- NOTE: set this before loading package manager

-- Simplify mapping in terminal
vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pV", ":Lexplore %:p:h<CR>")

-- Fix cyrillic Ctrl mappings
vim.keymap.set("n", "<C-с>", "<C-d>")
vim.keymap.set("n", "<C-ш>", "<C-u>")

-- NOTE: this keymap for xst/st term, in our case Ctrl-Backspace
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set({ "i", "v" }, "<C-s>", "<Esc><cmd>w<CR>")

-- gf files with spaces
vim.keymap.set("n", "gF", function()
    local line = vim.fn.getline(".")

    -- Remove 'directory:' from line
    local path = line:gsub("directory:", "")

    -- Remove leading spaces from path
    path = path:gsub("^%s+", "")

    -- Remove leading - from path
    path = path:gsub("^-", "")

    -- Remove quotes from path
    path = path:gsub('"', "")

    -- Go to path, using gf
    vim.cmd("e " .. path)
end, { desc = "gf files with spaces" })

-- move lines
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")

-- save cursor on center
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever, to replace selection with default register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- integrate system clipboard with <leader>y
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]])

-- Quickfix list navigation
-- TODO: need check and fix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace word under cursor -> send to command mode
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

-- Launch script using $TERMINAL
vim.keymap.set("n", "<leader>o", "<cmd>!$TERMINAL %<CR>", { silent = true })

-- Open file in external program (xdg-open)
vim.keymap.set("n", "<leader>O", "<cmd>!xdg-open %<CR>", { silent = true })

-- open Ex in nvim config directory
vim.keymap.set("n", "<Leader>vpe", ":e " .. vim_config_dir .. "<CR>", { desc = "Open Ex in nvim config directory" })

-- Quickly Destsroy current buffer
vim.keymap.set("n", "<M-x>", "<cmd>bd<CR>")

-- Show/hide special characters
vim.keymap.set("n", "<leader>vn", function()
    if vim.wo.list then
        vim.wo.list = false
    else
        vim.wo.list = true
        vim.wo.listchars = GLOBAL_LISTCHARS
    end
end)

-- Delete current file
-- TODO: need add confirmation
vim.keymap.set("n", "<S-M-Del>", "<cmd>call delete(expand('%:p')) | bdelete! %<CR>")

-- Insert new line below/upper current line
vim.keymap.set("n", "]<space>", "moo<Esc>`o")
vim.keymap.set("n", "[<space>", "moO<Esc>`o")

-- resize windows more quickly
vim.keymap.set("n", "<Leader>=", function()
    vim.cmd('exe "resize " . (winheight(0) * 3/2)')
end, { desc = "Resize window to 3/2" })

vim.keymap.set("n", "<Leader>-", function()
    vim.cmd('exe "resize " . (winheight(0) * 2/3)')
end, { desc = "Resize window to 2/3" })

-- close current buffer
vim.keymap.set("n", "<Leader>bd", ":bd<cr>", { desc = "Delete current buffer" })

-- close all buffers except current one
vim.keymap.set("n", "<Leader>bD", ":%bd|e#<cr>", { desc = "Close all buffers except current" })

-- Reload Config
vim.keymap.set("n", "<leader>vpr", "<cmd>lua ReloadConfig()<CR>", { desc = "Reload nvim config" })

-- requires some external tools

-- cd into current file path
vim.keymap.set("n", "<Leader>z%", function()
    vim.cmd("!cd %:p:h")
end, { desc = "cd into current file path" })

-- Plugin specific keymaps
-- Open lazy config
vim.keymap.set("n", "<leader>vpp", "<cmd>e " .. vim_config_dir .. "/lua/Personal/lazy.lua<CR>")

--
-- -- External commands
-- vim.keymap.set("n", "<Leader>oc",
-- ': silent !LDLIBS="-lcrypt -lcs50 -lm" clang "%" -o /tmp/a.out -lcs50 && kitty --hold -e /tmp/a.out<CR>')

--
--
-- -- search build.sh file in current directory and parent directories
-- local function search_build_sh_recursively(path)
--     local build_sh = path .. "/build.sh"
--     local build_bat = path .. "/build.bat"
--
--     if vim.fn.filereadable(build_sh) == 1 then
--         return build_sh
--     elseif vim.fn.filereadable(build_bat) == 1 then
--         return build_bat
--     end
--
--     -- if path included "Projects" then stop searching
--     local projects = vim.fn.expand("~/Projects")
--
--     -- if windows platform use different path
--     if vim.fn.has("win32") == 1 then
--         projects = vim.fn.expand("/w")
--     end
--
--     if vim.fn.fnamemodify(path, ":h") == projects then
--         return nil
--     end
--     -- if path is root then stop searching
--     if path == "/" then
--         return nil
--     end
--
--     return search_build_sh_recursively(vim.fn.fnamemodify(path, ":h"))
-- end
--
-- -- search build.sh file and run it, also run nvim-dap debugger
-- vim.keymap.set("n", "<Leader>bh", function()
--     local build_sh = search_build_sh_recursively(vim.fn.getcwd())
--     if build_sh then
--         -- save current file if it is modified
--         if vim.bo.modified then
--             vim.cmd("w")
--         end
--
--         -- run build.sh and if it exits with code 0 then run nvim-dap debugger
--         vim.cmd("silent !" .. build_sh)
--         -- if vim.v.shell_error == 0 then
--         --     vim.cmd("lua require('dap').continue()")
--         -- end
--     else
--         print("builder not found")
--     end
-- end)
--
--
-- -- run url_to_markdown_link.sh and then paste clipboard content
-- vim.keymap.set("n", "<Leader>pl", function()
--     vim.cmd("silent !url_to_markdown_link.sh")
--     local status = vim.v.shell_error
--     if status == 0 then
--         -- paste clipboard content
--         vim.cmd("normal! \"+p")
--     else
--         print("url_to_markdown_link.sh failed")
--     end
-- end, { desc = "Paste url as markdown link" })
--
-- -- run html2markdown.sh and then paste clipboard content
-- vim.keymap.set("n", "<Leader>ph", function()
--     vim.cmd("silent !html2markdown.sh")
--     local status = vim.v.shell_error
--     if status == 0 then
--         -- paste clipboard content
--         vim.cmd("normal! \"+p")
--     else
--         print("html2markdown.sh failed")
--     end
-- end, { desc = "Paste html as markdown" })

local function renameLinkedFile()
    local linkText = vim.fn.expand("<cWORD>")
    local linkedFileName = linkText:match("%((.-)%)")

    if linkedFileName then
        local newPath = vim.fn.input("New filename: ", linkedFileName)

        if newPath == "" then
            vim.notify("Empty filename", vim.log.levels.ERROR)
            return
        end

        vim.fn.rename(linkedFileName, newPath)

        -- Replace linkedFileName in curret line with newPath, escape / slaches
        vim.cmd("s/" .. vim.fn.escape(linkedFileName, "/") .. "/" .. vim.fn.escape(newPath, "/") .. "/")
    else
        print("No linked file detected.")
    end
end

vim.keymap.set("n", "<leader>rR", renameLinkedFile)

---

-- Insert timestamps from mpv
-- TODO: very scratchy, need to clean up/improve

function RunBashScript(file_path)
    -- Get the directory of the current lua script
    local script_path = vim.fn.expand(vim.fn.stdpath("config") .. "/lua/Personal")

    local bash_script = script_path .. "/mpv-start" -- Assuming myscript.sh is in the same directory
    if file_path == nil then
        local currentLine = vim.fn.getline(".")

        -- Define a pattern to match the filename and seconds
        local pattern = "%[(%d:%d%d:%d%d)%]%(<file://(.-)>%)"

        -- Extract filename and seconds using the pattern
        local duration, filename = currentLine:match(pattern)

        if filename then
            file_path = filename
        else
            file_path = vim.fn.input("File: ", "", "file")
        end
    elseif file_path == "" then
        vim.fn.jobstart(bash_script)
    end

    local absolute_path = vim.fn.expand(file_path)
    local job_id = vim.fn.jobstart({ bash_script, absolute_path })
end

function InsertTimestamp()
    -- Pause video
    vim.fn.system('echo \'{ "command": ["set_property", "pause", true] }\' | socat - /tmp/dublang-mpv.sock')

    -- Get required data
    local time_pos_data =
        vim.fn.system('echo \'{ "command": ["get_property", "time-pos"] }\' | socat - /tmp/dublang-mpv.sock')
    local file_path = vim.fn.system('echo \'{ "command": ["get_property", "path"] }\' | socat - /tmp/dublang-mpv.sock')
    file_path = vim.fn.json_decode(file_path)["data"]

    local time = math.floor(vim.fn.json_decode(time_pos_data)["data"])

    local days = math.floor(time / 86400)
    local remaining = time % 86400
    local hours = math.floor(remaining / 3600)
    remaining = remaining % 3600
    local minutes = math.floor(remaining / 60)
    remaining = remaining % 60
    local seconds = remaining

    if minutes < 10 then
        local minutes = "0" .. tostring(minutes)
    end
    if seconds < 10 then
        local seconds = "0" .. tostring(seconds)
    end

    -- Escape file path
    file_path = vim.fn.expand(file_path)
    -- Insert new line and go to next line
    -- vim.api.nvim_put({""}, "l", true, false)
    vim.api.nvim_put(
        { "[" .. hours .. ":" .. minutes .. ":" .. seconds .. "](<file://" .. file_path .. ">)" },
        "l",
        false,
        true
    )
    vim.api.nvim_put({ "  " }, "l", false, false)
    -- vim.a
    vim.cmd("startinsert!")
end

function OpenAndSeek()
    -- Input string
    local currentLine = vim.fn.getline(".")

    -- Define a pattern to match the filename and seconds
    local pattern = "%[(%d:%d%d:%d%d)%]%(<file://(.-)>%)"

    -- Extract filename and seconds using the pattern
    local duration, filename = currentLine:match(pattern)

    if not duration or not filename then
        print("No filename or duration found")
        return
    end

    -- Convert duration to seconds
    local hours, minutes, seconds = duration:match("(%d+):(%d+):(%d+)")
    local totalSeconds = hours * 3600 + minutes * 60 + seconds
    filename = vim.fn.expand(filename)

    local file_path = vim.fn.system('echo \'{ "command": ["get_property", "path"] }\' | socat - /tmp/dublang-mpv.sock')
    file_path = vim.fn.json_decode(file_path)["data"]
    if file_path ~= filename then
        vim.fn.system('echo \'{ "command" : ["loadfile", "' .. filename .. "\"] }' | socat - /tmp/dublang-mpv.sock && ")
    end
    vim.fn.system(
        'echo \'{ "command": ["seek", "' .. totalSeconds .. '", "absolute"] }\' | socat - /tmp/dublang-mpv.sock'
    )
end

-- Open mpv with initial file
vim.keymap.set(
    "n",
    "<leader>so",
    ":lua RunBashScript()<CR>",
    { noremap = true, silent = true, desc = "[MPV] Open mpv with initial file" }
)
vim.keymap.set(
    { "n", "i" },
    "<M-s>",
    InsertTimestamp,
    { noremap = true, silent = true, desc = "[MPV] Insert timestamp" }
)
vim.keymap.set(
    "n",
    "<leader>sf",
    OpenAndSeek,
    { noremap = true, silent = true, desc = "[MPV] Open and seek to timestamp" }
)

