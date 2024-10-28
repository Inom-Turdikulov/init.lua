local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup({
    -- Highlights the _whole_ line.
    --    Instead, use gitsigns.toggle_linehl()
    linehl = false,

    -- Highlights just the part of the line that has changed
    --    Instead, use gitsigns.toggle_word_diff()
    word_diff = false,

    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    signs_staged_enable = false,
    current_line_blame_opts = {
        delay = 2000,
        virt_text_pos = "eol",
    },
})

require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "[Gitsigns] next hunk" })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "[Gitsigns] prev hunk" })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = "[Gitsigns] stage hunk" })
        map('n', '<leader>hr', gs.reset_hunk, { desc = "[Gitsigns] reset hunk" })
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "[Gitsigns] stage hunk" })
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "[Gitsigns] reset hunk" })
        map('n', '<leader>hS', gs.stage_buffer, { desc = "[Gitsigns] stage buffer" })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "[Gitsigns] undo stage hunk" })
        map('n', '<leader>hR', gs.reset_buffer, { desc = "[Gitsigns] reset buffer" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "[Gitsigns] preview hunk" })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "[Gitsigns] blame line" })
        map('n', '<leader>hB', gs.toggle_current_line_blame, { desc = "[Gitsigns] toggle current line blame" })
        map('n', '<leader>hd', gs.diffthis, { desc = "[Gitsigns] diffthis" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "[Gitsigns] diffthis ~" })
        map('n', '<leader>hx', gs.toggle_deleted, { desc = "[Gitsigns] toggle deleted" })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "[Gitsigns] select hunk" })
    end
}
