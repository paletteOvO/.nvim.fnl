(import-macros { : require-as! } :user.macros.require)

(require-as! autosave :auto-save)

(autosave.setup {
   :execution_message {
      :message (lambda [] "")
      :cleaning_interval 0
      }
   :clean_command_line_interval 1
   :enabled true
   :events [ "InsertLeave" ]
   :conditions (lambda [buf] 
      (local vfn vim.fn)
      (local utils (require "auto-save.utils.data"))
      (if
         (and
            (= (vfn.getbufvar buf "&modifiable") 1)
            (utils.not_in (vfn.getbufvar buf "&filetype") {})
         )
         false
         false
      )
   )
})
