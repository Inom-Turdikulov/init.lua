local ok_neotest, neotest = pcall(require, "neotest")
if not ok_neotest then
    return
end

local ok_neotest_python, neotest_python = pcall(require, "neotest-python")
if not ok_neotest_python then
    return
end

neotest.setup({
    floating = {
        border = "double",
        max_height = 0.6,
        max_width = 0.6,
    },

    adapters = {
        neotest_python({
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = { justMyCode = false, console = "integratedTerminal" },
            -- Command line arguments for runner
            -- Can also be a function to return dynamic values
            args = { "-vv", "-s", "--log-level", "DEBUG" },
            -- Runner to use. Will use pytest if available by default.
            -- Can be a function to return dynamic value.
            runner = "pytest",
        }),
    },
})

local map = function(lhs, rhs, desc)
    if desc then
        desc = "[Neotest] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader>dnn", function()
    neotest.run.run()
end, "neotest run the nearest test")

map("<leader>dnl",
    neotest.run.run_last,
    "neotest run the last test")

map("<leader>dnc", function()
    neotest.run.run({ strategy = "dap" })
    -- you can add here additional commands, like neotest.summary.open()
end, "debug the nearest test")

map("<leader>dnS", function()
    neotest.summary.open()
end, "open the summary window")

map("<leader>dnf", function()
    neotest.run.run(vim.fn.expand("%"))
end, "run the current file")

map("<leader>dna", neotest.run.attach, "attach to the nearest test")
map("<leader>dns", neotest.run.stop, "stop the nearest test")

map("<leader>dno", function()
    neotest.output.open({ enter = true })
end, "open the output of a test result")

map("<leader>dnt", neotest.output_panel.toggle, "toggle the output panel")

map("]n", neotest.jump.next, "Neotest jump to the next test")
map("[n", neotest.jump.prev, "Neotest jump to the previous test")
