local ok, xkbswitch = pcall(require, "xkbswitch")
if not ok then return end

xkbswitch.setup()
