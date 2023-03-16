(import-macros { : require-as! } :user.macros.require)

(require-as! autopairs :nvim-autopairs)
(require-as! Rule :nvim-autopairs.rule)
(require-as! cond :nvim-autopairs.conds)

(autopairs.setup {
   :check_ts true
   :disable_filetype [ "TelescopePrompt" ]
   :enable_check_bracket_line false
   :ts_config {
      :lua [ "string" ] ;; it will not add a pair on that treesitter node
      :javascript [ "template_string" ]
   }
   :map_cr false
})

(autopairs.remove_rule "'")
(autopairs.remove_rule "`")

(autopairs.add_rule (Rule "'" "'" ["-fennel" "-rust"]))
(autopairs.add_rule (Rule "`" "`" ["-fennel"]))

(require-as! cmp_autopairs :nvim-autopairs.completion.cmp)
(require-as! cmp :cmp)
(cmp.event:on :confirm_done cmp_autopairs.on_confirm_done {})

