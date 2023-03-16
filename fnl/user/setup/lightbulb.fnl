(import-macros { : require-as! } :user.macros.require)

(require-as! lightbulb :nvim-lightbulb)

(lightbulb.setup {
   :autocmd {
      :enable true
      :evnets ["InsertLeave"]
   }
})
