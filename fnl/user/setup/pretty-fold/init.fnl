(import-macros { : require-as! } :user.macros.require)

(require-as! pretty-fold :pretty-fold)

(pretty-fold.setup {
   :keep_indentation true
   :fill_char "-"
   :sections {
      :left [ "+" "content" ]
      :right [
         " " 
         "number_of_folded_lines"
         ":"
         (lambda [] (string.rep "-" vim.v.foldlevel))
      ]
   }
   :matchup_patterns [
      [ "{" "}" ]
      [ "%(" ")" ]
      [ "%[" "]" ]
   ]
})

(require-as! preview :pretty-fold.preview)
(preview.setup)

(local ft [
   :ft_lua
])

(each [_ v (ipairs ft)]
   (require-as! _ (.. :user.setup.pretty-fold. v))
)

