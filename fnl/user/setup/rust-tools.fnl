(import-macros { : require-as! } :user.macros.require)

(require-as! rust-tools :rust-tools)

(rust-tools.setup {
   :tools {
      :inlay_hints {
         :auto false
      }
   }
})

