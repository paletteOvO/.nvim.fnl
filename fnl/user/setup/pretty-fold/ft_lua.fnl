(import-macros { : require-as! } :user.macros.require)

(require-as! pretty-fold :pretty-fold)

(pretty-fold.ft_setup "lua"
   {
      :matchup_patterns [   
         [ "^%s*do$" "end" ] ;; do ... end blocks
         [ "^%s*if" "end" ] ;; if ... end
         [ "^%s*for" "end" ] ;; for
         [ "function%s*%(" "end" ] ;; 'function( or 'function (''
         [ "{" "}" ]
         [ "%(" ")" ] ;; % to escape lua pattern char
         [ "%[" "]" ] ;; % to escape lua pattern char
      ]
   }
)
