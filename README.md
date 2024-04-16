# init.lua

My personal neovim configuration, highly inspired by ThePrimeagen's and TeejDv's
configurations.

How to install?

Put this repository (copy directory contents or make symlink) in neovim config
path, you can find it by running `:echo stdpath('config')` in neovim.

## LSP servers

I manage all my LSP servers using NixOS

## TODO

- [ ] Go through shortcuts
- [ ] LSP telescope function check, DAP shortcuts check
- [ ] print in config not really works (at least in telekasten.lua on startup).
Need to use some notification systems, vim.notify?
- [ ] review and maybe integrate some changes from these articles:
  - https://davelage.com/posts/nvim-dap-getting-started/
  - https://miguelcrespo.co/posts/how-to-debug-like-a-pro-using-neovim/
  - https://harrisoncramer.me/debugging-in-neovim/
  - https://stackoverflow.com/questions/71810002/how-to-configure-the-dap-debugger-under-neovim-for-typescript
