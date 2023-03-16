(import-macros { : require-as! } :user.macros.require)

;; Setup nvim-cmp
(require-as! hover :hover)
(hover.setup {
   :init (lambda [] 
      (require :hover.providers.lsp)
   )
   :preview_opts {
      :border "single"
   }
   :preview_window false
   :title true
})

