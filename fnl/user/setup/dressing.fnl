(import-macros { : require-as! } :user.macros.require)

(require-as! dressing :dressing)

(dressing.setup {
   :input {
      :enabled true
      :border :single
   }
   :select {
      :enabled true
      :border :single
      :nui {
         :border {
            :style :single
         }
      }
   }
   :builtin {
      :enabled true
      :border :single
   }

})
