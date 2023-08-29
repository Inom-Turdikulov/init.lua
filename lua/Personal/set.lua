GLOBAL_LISTCHARS = "tab:>-,extends:>,precedes:<,nbsp:␣,eol:↵"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff=4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"


-- Show return characters
vim.wo.list = true
vim.wo.listchars = GLOBAL_LISTCHARS

-- Custom highlighting in diff mode
vim.opt.diffopt:append { 'linematch:50' }

-- Open diff in vertical split
vim.opt.diffopt:append { 'vertical' }

-- Enable syntax highlight in code blocks
vim.g.markdown_fenced_languages = {
    'python', 'cpp', 'javascript',
    'java', 'rust', 'php', 'sql',
    'typescript', 'ruby', 'go',
    'lua', 'bash=sh',
    'js=javascript', 'json=javascript', 'typescript',
    'html', 'css', 'scss',
    'yaml', 'toml', 'tex', 'nix'
}

-- Set window title to the current base directory
vim.opt.title = true
vim.opt.titlestring = "%{expand('%:p:h:t')}"
vim.g.markdown_folding = 1 -- enable markdown folding

-- if windows set specific options, fix shell in msys2 (windows)
if vim.fn.has('win32') == 1 then
    vim.opt.shellcmdflag = "-c"
end

-- Netrw settings
vim.g.nerw_keepdir = 0 --  avoid the move files error.
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localcopydircmd = 'cp -r'  -- fix netrw recursive dir copy

-- Save data in session
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Cursorline highlighting control
--  Only have it on in the active buffer
vim.opt.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")
