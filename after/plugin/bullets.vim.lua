vim.cmd[[
" Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]

let g:bullets_set_mappings = 0 " disable adding default key mappings, default = 1

" default = []
" N.B. You can set these mappings as-is without using this g:bullets_custom_mappings option but it
" will apply in this case for all file types while when using g:bullets_custom_mappings it would
" take into account file types filter set in g:bullets_enabled_file_types, and also
" g:bullets_enable_in_empty_buffers option.
let g:bullets_custom_mappings = [
  \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
  \ ['inoremap', '<C-cr>', '<cr>'],
  \
  \ ['nmap', 'o', '<Plug>(bullets-newline)'],
  \
  \ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
  \ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
  \
  \ ['nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)'],
  \
  \ ['imap', '<C-t>', '<Plug>(bullets-demote)'],
  \ ['nmap', '>>', '<Plug>(bullets-demote)'],
  \ ['vmap', '>', '<Plug>(bullets-demote)'],
  \ ['imap', '<C-d>', '<Plug>(bullets-promote)'],
  \ ['nmap', '<<', '<Plug>(bullets-promote)'],
  \ ['vmap', '<', '<Plug>(bullets-promote)'],
  \ ]
]]
