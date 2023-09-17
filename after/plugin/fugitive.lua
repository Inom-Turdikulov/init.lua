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
        if vim.bo.ft == "diff" then
            -- TODO: need test it
            vim.keymap.set("n", "gn", "<cmd>diffget //2<CR>") -- select left side of diff
            vim.keymap.set("n", "gt", "<cmd>diffget //3<CR>") -- select right side of diff
        end

        if vim.bo.ft ~= "fugitive" then
            return
        end

        vim.notify("Fugitive buffer opened")

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git({ 'pull --rebase' })
        end, opts)

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
        vim.keymap.set("n", "<leader>T", ":Git push -o merge_request.create --set-upstream origin -u origin ", opts);
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

-- Keymaps
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set('n', '<leader>gg', toggleFugitiveGit,
    { desc = 'Toggle Git window', noremap = true })

vim.keymap.set("n", "<leader>gl", ":Gclog<CR>")
vim.keymap.set("n", "<leader>gb", ":Git branch<Space>")

vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>")
vim.keymap.set("n", "<leader>gD", ":Git diff<CR>")
vim.keymap.set("n", "<leader>ge", ":Gedit<CR>")
--
-- capitalize W/R to reduce unwanted changes
vim.keymap.set("n", "<leader>gW", ":Gwrite<CR>")
vim.keymap.set("n", "<leader>gR", ":Gread<CR>")

vim.keymap.set("n", "<leader>ga", ":Git commit -v -q --amend<CR>")
vim.keymap.set("n", "<leader>gA", ":Git add -p<CR>") -- add with patch

vim.keymap.set("n", "<leader>gp", ":Ggrep<Space>")
vim.keymap.set("n", "<leader>gm", ":GMove<Space>")
vim.keymap.set("n", "<leader>go", ":Git checkout<Space>")
