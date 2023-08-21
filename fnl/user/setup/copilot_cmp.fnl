(import-macros { : require-as! } :user.macros.require)

(require-as! copilot_cmp "copilot_cmp")
(copilot_cmp.setup {
   :formatters {
      :insert_text (. (require "copilot_cmp.format") :remove_existing)
   }
})
