# init.lua
My personal neovim configuration

## LSP servers

I manage all my LSP servers using NixOS, except `emmet-ls`.
I need manually install it with:
`npm i -g emmet-ls`
- [ ] use nix shell with npm2nix or yarn2nix or integrate into configuration?

## TODO

- [x] LSP icons check
- [ ] Learn lua: https://github.com/nanotee/nvim-lua-guide
- [ ] Go through shortcuts
- [ ] LSP telescope function check, DAP shortcuts check
- [ ] print in config not really works (at least in telekasten.lua on startup).
Need to use some notification systems?
- [ ] review and maybe integrate some changes from these articles:
  - https://davelage.com/posts/nvim-dap-getting-started/
  - https://miguelcrespo.co/posts/how-to-debug-like-a-pro-using-neovim/
  - https://harrisoncramer.me/debugging-in-neovim/
  - https://stackoverflow.com/questions/71810002/how-to-configure-the-dap-debugger-under-neovim-for-typescript
- [x] integrate https://github.com/creativenull/efmls-configs-nvim
- [x] port old LSP keybindings
- [x] port configuration
- [x] check https://github.com/zbirenbaum/copilot-cmp
- [k] ~~move this into NixOS configuration~~
