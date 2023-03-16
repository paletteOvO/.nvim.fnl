(import-macros { : require-as! } :user.macros.require)

(require-as! gitsigns :gitsigns)

(gitsigns.setup {
   :current_line_blame true
   :current_line_blame_opts {
      :delay 0
   }
   :signs {
      :add { :hl  "GitSignsAdd" :text  "▎" :numhl "GitSignsAddNr" :linehl "GitSignsAddLn" }
      :change  { :hl  "GitSignsChange" :text "▎" :numhl "GitSignsChangeNr" :linehl "GitSignsChangeLn" }
      :delete  { :hl  "GitSignsDelete" :text  "> " :numhl "GitSignsDeleteNr" :linehl "GitSignsDeleteLn" }
      :topdelete { :hl  "GitSignsDelete" :text  "> " :numhl "GitSignsDeleteNr" :linehl "GitSignsDeleteLn" }
      :changedelete  { :hl  "GitSignsChange" :text"▎" :numhl "GitSignsChangeNr" :linehl "GitSignsChangeLn" }
   }
}) 

