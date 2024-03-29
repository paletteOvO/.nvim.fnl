(import-macros { : require-as! } :user.macros.require)

(vim.cmd "let g:neo_tree_remove_legacy_commands = 1")
(require-as! neo-tree :neo-tree)

(neo-tree.setup {
   :close_if_last_window true
   :popup_border_style "single"
   :use_popups_for_input true
   :sort_case_insensitive true
   :window {
      :width 30
      :mappings {
         "<space>" :none
      }
   }
   :default_component_configs  {
      :indent {
         :indent_size 2
      }
      :icon {
         :folder_closed ""
         :folder_empty ""
         :folder_open ""
      }
   }
   :source_selector {
      :winbar true
      ; :tab_labels {
      ;    :filesystem "File"
      ;    :buffers "Buffer"
      ;    :git_status "Git"
      ;    :diagnostics "Diagnostic"
      ; }
      :content_layout "left"
      :tabs_layout "active"
      :padding 0
      :separator { :left "" :right ""}
   }
   :filesystem {
      :use_libuv_file_watcher true
      :filtered_items {
         ; :hide_gitignored false
         :visible true
         :always_show [ ;; remains visible even if other settings would normally hide it
           ".gitignore"
         ]
      }
      :follow_current_file true
   }
   :buffers {
      :follow_current_file true
      :window {
         :mappings {
            :bd "buffer_delete"
            :d "buffer_delete"
            "<DEL>" "buffer_delete"
         }
      }
   }
})
