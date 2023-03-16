(import-macros { : require-as! } :user.macros.require)

(require-as! Comment "Comment")

(Comment.setup {
   :pre_hook (lambda [ctx]
      (local line_start (- (or ctx.srow ctx.range.srow) 1))
      (local line_end (or ctx.erow ctx.range.erow))
      (require-as! core "lsp-inlayhints.core")
      (core.clear 0 line_start line_end)
   )
})

