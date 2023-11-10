(import-macros { : require-as! } :user.macros.require)

(require-as! fidget :fidget)

(fidget.setup {
   :progress {
      :display {
         :progress_icon {
            :pattern "dots"
            :period 3
         }
      }
   }
})
