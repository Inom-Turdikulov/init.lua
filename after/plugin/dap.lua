local has_dap, dap = pcall(require, "dap")
if not has_dap then
    return
end

local has_dap_virtual_text, dap_virtual_text = pcall(require, "dap-virtual-text")
if not has_dap_virtual_text then
    return
end

-- Configure custom signs
vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ü", texthl = "", linehl = "", numhl = "" })

-- Setup cool Among Us as avatar
vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })

-- TODO: How does terminal work?
local terminal = vim.env.TERMINAL
local terminal_path = vim.fn.trim(vim.fn.system("which " .. terminal))
dap.defaults.fallback.external_terminal = {
    command = terminal_path,
    args = { "-e" },
}

-- Virtual text
dap_virtual_text.setup {
    enabled = true,

    -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
    enabled_commands = false,

    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_changed_variables = true,
    highlight_new_as_changed = true,

    -- prefix virtual text with comment string
    commented = false,

    show_stop_reason = true,

    -- experimental features:
    virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
}

-- -- Lua configuration
-- dap.adapters.nlua = function(callback, config)
--     callback { type = "server", host = config.host, port = config.port }
-- end
--
-- dap.configurations.lua = {
--     {
--         type = "nlua",
--         request = "attach",
--         name = "Attach to running Neovim instance",
--         host = function()
--             return "127.0.0.1"
--         end,
--         port = function()
--             -- local val = tonumber(vim.fn.input('Port: '))
--             -- assert(val, "Please provide a port number")
--             local val = 54231
--             return val
--         end,
--     },
-- }
--
-- -- C configuration
-- -- lldb-vscode is part of the lldb/llvm package
-- -- check if lldb is available
-- if vim.fn.executable("lldb-vscode") == 1 then
--   dap.adapters.c = {
--       name = "lldb",
--       type = "executable",
--       attach = {
--           pidProperty = "pid",
--           pidSelect = "ask",
--       },
--       command = "lldb-vscode",
--       env = {
--           LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
--       },
--   }
--   dap.configurations.c = {
--       {
--           -- If you get an "Operation not permitted" error using this, try disabling YAMA:
--           --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--           --
--           -- Careful, don't try to attach to the neovim instance that runs *this*
--           name = "Fancy attach",
--           type = "c",
--           request = "attach",
--           pid = function()
--               local output = vim.fn.system { "ps", "a" }
--               local lines = vim.split(output, "\n")
--               local procs = {}
--               for _, line in pairs(lines) do
--                   -- output format
--                   --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
--                   local parts = vim.fn.split(vim.fn.trim(line), " \\+")
--                   local pid = parts[1]
--                   local name = table.concat({ unpack(parts, 5) }, " ")
--                   if pid and pid ~= "PID" then
--                       pid = tonumber(pid)
--                       if pid ~= vim.fn.getpid() then
--                           table.insert(procs, { pid = pid, name = name })
--                       end
--                   end
--               end
--               local choices = { "Select process" }
--               for i, proc in ipairs(procs) do
--                   table.insert(choices,
--                       string.format("%d: pid=%d name=%s", i, proc.pid, proc.name))
--               end
--               -- Would be cool to have a fancier selection, but needs to be sync :/
--               -- Should nvim-dap handle coroutine results?
--               local choice = vim.fn.inputlist(choices)
--               if choice < 1 or choice > #procs then
--                   return nil
--               end
--               return procs[choice].pid
--           end,
--           args = {},
--       },
--       --[[
--     {
--       "type": "gdb",
--       "request": "attach",
--       "name": "Attach to gdbserver",
--       "executable": "<path to the elf/exe file relativ to workspace root in order to load the symbols>",
--       "target": "X.X.X.X:9999",
--       "remote": true,
--       "cwd": "${workspaceRoot}",
--       "gdbpath": "path/to/your/gdb",
--       "autorun": [
--               "any gdb commands to initiate your environment, if it is needed"
--           ]
--   }
--     --]]
-- }
--
-- end
--
--
-- -- Python configuration
-- local pythonPath = function()
--     -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--     -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--     -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--     -- custom path to python3 if PYTHONPATH is set
--     if vim.env.PYTHONPATH then
--         return vim.env.PYTHONPATH
--     else
--         return 'python3'
--     end
-- end
--
-- dap.configurations.python = {
--     {
--         type = "python",
--         request = "launch",
--         name = "Launch with terminal",
--         program = "${file}",
--         args = {},
--         console = "integratedTerminal",
--     },
--     {
--         type = 'python',
--         request = 'launch',
--         name = 'SLP Flask App',
--         module = 'flask',
--         env = {
--             FLASK_APP = 'wsgi.py',
--             FLASK_ENV = 'development',
--             FLASK_DEBUG = '1',
--         },
--         args = {
--             'run',
--             '--no-debugger',
--             '--host=0.0.0.0',
--             '--port=45120',
--         },
--         pythonPath = function()
--             return 'python'
--         end,
--         cwd = vim.fn.getcwd(),
--         jinja = true,
--         -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
--     },
--     {
--         type = 'python',
--         request = 'launch',
--         module = 'celery',
--         name = 'SLP Celery Workers',
--         args = {
--             "worker",
--             "--app=wsgi.celery",
--             "--concurrency=1",
--             "--loglevel=DEBUG",
--             "--queues=linkedin_default",
--             "-B"
--         },
--         gevent = true,
--         console = 'integratedTerminal',
--         cwd = vim.fn.getcwd(),
--         env = {
--             CELERY_TASK_ALWAYS_EAGER = 'True',
--             AUTH_DEV                 = "KEYCLOAK_AUTH_DISABLED",
--             LOG_NAME                 = "tasks",
--             GEVENT_SUPPORT           = 'True'
--         }
--     }
-- }
--
-- local dap_python = require "dap-python"
-- dap_python.setup("python", {
--     -- So if configured correctly, this will open up new terminal.
--     --    Could probably get this to target a particular terminal
--     --    and/or add a tab to kitty or something like that as well.
--     console = "externalTerminal",
--     include_configs = true,
-- })
--
-- vim.g.python3_host_prog = pythonPath()
-- require('dap-python').setup(vim.g.python3_host_prog)
-- require('dap-python').test_runner = 'pytest'
--
-- dap.configurations.rust = {
--     {
--         name = "Launch",
--         type = "lldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/",
--                 "file")
--         end,
--         cwd = "${workspaceFolder}",
--         stopOnEntry = false,
--         args = {},
--         -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--         --
--         --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--         --
--         -- Otherwise you might get the following error:
--         --
--         --    Error on launch: Failed to attach to the target process
--         --
--         -- But you should be aware of the implications:
--         -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--         runInTerminal = false,
--     },
-- }
--
--
-- -- Configure dap to use vscode-cpptools
-- -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
-- dap.adapters.cppdbg = {
--     id = 'cppdbg',
--     type = 'executable',
--     command = 'OpenDebugAD7',
-- }
--
-- dap.configurations.cpp = {
--     {
--         name = "Handmade Hero",
--         type = "cppdbg",
--         request = "launch",
--         program = function()
--             return vim.fn.expand(
--                 '~/Projects/main/handmadehero/build/linux_handmade')
--         end,
--         cwd = '${workspaceFolder}',
--         stopAtEntry = true,
--     },
-- }
--
--
-- -- You can set trigger characters OR it will default to '.'
-- -- You can also trigger with the omnifunc, <c-x><c-o>
-- vim.cmd [[
-- augroup DapRepl
--   au!
--   au FileType dap-repl lua require('dap.ext.autocompl').attach()
-- augroup END
-- ]]
--
-- local dap_ui = require "dapui"
--
-- local _ = dap_ui.setup {
--     layouts = {
--         {
--             elements = {
--                 "scopes",
--                 "breakpoints",
--                 "stacks",
--                 "watches",
--             },
--             size = 40,
--             position = "right",
--         },
--         {
--             elements = {
--                 {
--                     id = "repl",
--                     size = 0.375,
--                 },
--                 {
--                     id = "console",
--                     size = 0.625,
--                 },
--             },
--             size = 10,
--             position = "bottom",
--         },
--     },
-- }
--
-- local original = {}
-- local debug_map = function(lhs, rhs, desc)
--     local keymaps = vim.api.nvim_get_keymap "n"
--     original[lhs] = vim.tbl_filter(function(v)
--             return v.lhs == lhs
--         end, keymaps)[1] or true
--
--     vim.keymap.set("n", lhs, rhs, { desc = desc })
-- end
--
-- local debug_unmap = function()
--     for k, v in pairs(original) do
--         if v == true then
--             vim.keymap.del("n", k)
--         else
--             local rhs = v.rhs
--
--             v.lhs = nil
--             v.rhs = nil
--             v.buffer = nil
--             v.mode = nil
--             v.sid = nil
--             v.lnum = nil
--
--             vim.keymap.set("n", k, rhs, v)
--         end
--     end
--
--     original = {}
-- end
--
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--     -- debug_map("asdf", ":echo 'hello world<CR>", "showing things")
--
--     dap_ui.open()
-- end
--
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--     debug_unmap()
--
--     dap_ui.close()
-- end
--
-- dap.listeners.before.event_exited["dapui_config"] = function()
--     dap_ui.close()
-- end
--
-- -- load telescope dap
-- require('telescope').load_extension('dap')
