local ok, indentomatic = pcall(require, "indent-o-matic")
if not ok then return end
indentomatic.setup {}
