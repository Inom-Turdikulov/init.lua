local ok_neotest, neotest = pcall(require, "neotest")
if not ok_neotest then
    return
end

local ok_neotest_python, neotest_python = pcall(require, "neotest-python")
if not ok_neotest_python then
    return
end

neotest.setup({
    adapters = {
        neotest_python({
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = { justMyCode = false },
            -- Command line arguments for runner
            -- Can also be a function to return dynamic values
            args = { "--log-level", "DEBUG" },
            -- Runner to use. Will use pytest if available by default.
            -- Can be a function to return dynamic value.
            runner = "pytest",
        })
    }
})
