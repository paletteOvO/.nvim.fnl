(import-macros { : require-as! } :user.macros.require)

(require-as! tabnine :cmp_tabnine.config)

; (tabnine.setup {
;    :disable_auto_comment true
;    :accept_keymap "<NUL>"
;    :dismiss_keymap "<NUL>"
;    :exclude_filetypes [
;       "TelescopePrompt"
;    ]
; })

(tabnine:setup {
   :max_lines 1000
   :max_num_results 2
   :sort true
   :run_on_every_keystroke true
   :snippet_placeholder ".."
   :ignored_file_types [
      "TelescopePrompt"
   ]
   :show_prediction_strength false
})
