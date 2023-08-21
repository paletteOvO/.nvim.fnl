(import-macros { : require-as! } :user.macros.require)

(require-as! lualine :lualine)

(fn hide_in_width [] (> (vim.fn.winwidth 0) 80))

(local lsp_server {
   1 (lambda [] (do
      (local msg "-")
      (local buf_ft (vim.api.nvim_buf_get_option 0 "filetypes"))
      (local clients (vim.lsp.get_active_clients))
      (if (~= (next clients) nil)
         (do
            (each [_ client (ipairs clients)]
               (local filetypes client.config.filetypes)
               (if (and filetypes (~= (vim.fn.index filetypes buf_ft) -1))
                  (lua "return client.name")
               )
            )
         )
      )
      msg
   ))
   :icon ""
   :color { :gui "bold" }
})

(local diagnostics {
   1 "diagnostics"
   :sources [ :nvim_diagnostic ]
   :sections [ :error :warn ]
   :symbols { :error " " :warn " " }
   :colored false
   :always_visible true
})

(local diff {
   1 :diff
   :colored false
   :symbols { :added "+" :modified "~" :removed "-"}
   :cond hide_in_width
})

(local filetype {
   1 :filetype
   :icons_enabled false
})

(local spaces (lambda [] 
   (.. "spaces: " (vim.api.nvim_buf_get_option 0 "shiftwidth"))
))

(lualine.setup {
   :options {
      :globalstatus true
      :icons_enabled true
      :theme "catppuccin"
      :component_separators ""
      :section_separators { :left "" :right "" }
      :disabled_filetypes [ "alpha" "dashboard" ]
      ;; :always_divide_middle true
   }
   :sections {
      :lualine_a [
         { 1 "mode" :fmt (lambda [str] (.. " " str)) :separator { :left "" :right "" } :right_padding 2 }
      ]
      :lualine_b [ "branch" ]
      :lualine_c [ "filename" lsp_server diagnostics ]
      :lualine_x [ diff spaces :encoding filetype ]
      :lualine_y [ { 1 "location" :padding 1 :separator { :left "" :right ""} } ]
      :lualine_z []
   }
})
