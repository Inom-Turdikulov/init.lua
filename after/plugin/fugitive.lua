if not vim.g.loaded_fugitive then
    return
end

-- Automatically start insert mode when opening gitcommit buffers
vim.cmd [[
    autocmd FileType gitcommit startinsert
]]

local Personal_Fugitive = vim.api.nvim_create_augroup("Personal_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = Personal_Fugitive,
    pattern = "*",
    callback = function()
        local map = function(lhs, rhs, desc)
            local bufnr = vim.api.nvim_get_current_buf()
            if desc then
                desc = "[Fugitive] " .. desc
            end

            vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc, remap = false })
        end

        if vim.bo.ft == "diff" then
            -- TODO: need test it
            map("gn", "<cmd>diffget //2<CR>", "select left side of diff")
            map("gt", "<cmd>diffget //3<CR>", "select right side of diff")
        end

        if vim.bo.ft ~= "fugitive" then
            return
        end

        map("<leader>pp", function()
            vim.cmd.Git('push')
        end, "Git push")

        -- rebase always
        map("<leader>pP", function()
            vim.cmd.Git({ 'pull --rebase' })
        end, "Git pull")

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        map("<leader>pt", ":Git push -u origin ", "Git push origin");
        map("<leader>pT", ":Git push -o merge_request.create --set-upstream origin -u origin ", "Git push with MR");
    end,
})


-- fugitive git bindings
local function showFugitiveGit()
    if vim.fn.FugitiveHead() ~= '' then
        vim.cmd [[
        Git
        setlocal nonumber
        setlocal norelativenumber
        ]]
    end
end
local function toggleFugitiveGit()
    if vim.fn.buflisted(vim.fn.bufname('fugitive:///*/.git//$')) ~= 0 then
        vim.cmd [[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]]
    else
        showFugitiveGit()
    end
end

-- Main Keymaps

local map = function(lhs, rhs, desc)
    if desc then
        desc = "[Fugitive] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map('<leader>gg', toggleFugitiveGit, 'toggle panel')
map("<leader>gs", vim.cmd.Git, "panel")

map("<leader>gl", ":Gclog<CR>", "log")
map("<leader>gb", ":Git branch<Space>", "branch")

map("<leader>gd", ":Gdiffsplit<CR>", "diff split")
map("<leader>gD", ":Git diff<CR>", "diff")
map("<leader>ge", ":Gedit<CR>", "edit")
--
-- capitalize W/R to reduce unwanted changes
map("<leader>gW", ":Gwrite<CR>", "write")
map("<leader>gR", ":Gread<CR>", "read")

map("<leader>ga", ":Git commit -v -q --amend<CR>", "ammend")
map("<leader>gA", ":Git add -p<CR>", "add with patch")

map("<leader>gp", ":Ggrep<Space>", "grep")
map("<leader>gm", ":GMove<Space>", "move")
map("<leader>go", ":Git checkout<Space>", "checkout")
