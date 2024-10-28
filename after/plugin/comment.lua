local ok, comment = pcall(require, "Comment")
if not ok then return end
comment.setup({
    -- Fix comments for react components
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
