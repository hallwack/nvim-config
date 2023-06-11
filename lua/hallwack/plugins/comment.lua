return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring'
  },
  config = function()
    local ok_comment, comment = pcall(require, 'Comment')
    if not ok_comment then return end

    comment.setup({
      pre_hook = function(context)
        local utils = require("Comment.utils")

        local location = nil

        if context.ctype == utils.ctype.block then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif context.cmotion == utils.cmotion.v or context.cmotion == utils.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({
          key = context.ctype == utils.ctype.line and "__default" or "__multiline",
          location = location,
        })
      end,
    })
  end
}
