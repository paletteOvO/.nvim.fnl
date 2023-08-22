(import-macros { : require-as! } :user.macros.require)

(require-as! rust-tools :rust-tools)

(rust-tools.setup {
   :tools {
      :inlay_hints {
         :auto false
      }
   }
   :server {
      :on_attach (lambda [client bufnr]
         (local handlers (require "user.lsp.handlers"))
         (handlers.on_attach client bufnr)
      )
   }
})

