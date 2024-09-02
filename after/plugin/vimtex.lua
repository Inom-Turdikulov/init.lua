-- Run compilation on start
vim.cmd [[
:autocmd BufNewFile,BufRead *.tex VimtexCompile
]]

-- Live compilation
vim.g.vimtex_compiler_latexmk = {
    build_dir = '.out',
    options = {
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-interaction=nonstopmode',
        '-synctex=1'
    }
}
vim.g.vimtex_view_method = 'sioyek'