(import-macros { : require-as! } :user.macros.require)

(require-as! copilot "copilot")
(copilot.setup {
   :panel {
      :enable false
   }
   :suggestion {
      :enable false
   }
   :ft_disable [ "alpha" "Telescope" "TelescopePrompt"]
})
