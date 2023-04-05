(import-macros { : require-as! } :user.macros.require)

(require-as! lsp_signature :lsp_signature)

(lsp_signature.setup {
   :bind true 
   :handler_opts {
      :border :single
   }
   :hint_prefix "// "
   :handler_opts {
      :border :single
   }
})
; (lsp_signature.on_attach)
