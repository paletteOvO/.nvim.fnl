(import-macros { : require-as! } :user.macros.require)

(vim.cmd "let g:neo_tree_remove_legacy_commands = 1")
(require-as! neo-tree :neo-tree)
(neo-tree.setup {
   :close_if_last_window true
   :popup_border_style "rounded"
   :use_popups_for_input false
   :sort_case_insensitive true
   :window {
      :width 30
      :mappings {
         "<space>" :none
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
         :always_show [ ;; remains visible even if other settings would normally hide it
           ".gitignored"
         ]
      }
      :follow_current_file true
   }
   :buffers {
      :follow_current_file true
   }
   :default_component_configs {
      :indent {
         :indent_size 2
      }
   }
})
