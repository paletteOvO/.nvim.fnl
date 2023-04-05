(import-macros { : require-as! } :user.macros.require)

(require-as! telescope :telescope)
(require-as! actions :telescope.actions)

(telescope.setup {
   :defaults {
      :prompt_prefix " "
      :selection_caret " "
      :path_display [ "smart" ]
      :file_ignore_patterns [ ".git/" "node_modules" ]
      :preview { :treesitter false }
      :mappings {
         :i {
            "<C-Down>" actions.cycle_history_next
            "<C-Up>" actions.cycle_history_prev
            "<Down>" actions.move_selection_next
            "<Up>" actions.move_selection_previous
         }
      }
   }
})

(telescope.load_extension :fzf)
