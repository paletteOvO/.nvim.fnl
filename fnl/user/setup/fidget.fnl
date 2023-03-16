(import-macros { : require-as! } :user.macros.require)

(require-as! fidget :fidget)

(fidget.setup {
   :text {
      :spinner ["   " ".  " ".. " "..."]
   }
})
