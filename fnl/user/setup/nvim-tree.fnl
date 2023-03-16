(import-macros { : require-as! } :user.macros.require)

(require-as! nvim-tree :nvim-tree)
(require-as! config :nvim-tree.config)

(local tree_cb config.nvim_tree_callback)

(nvim-tree.setup {
  :git {
    :timeout 200
    :ignore false
    :enable true
  }
  :view {
    :side "left"
    :hide_root_folder true
    ;; :adaptive_size true
    ;; :signcolumn "no"
    ;; :height 30
    :mappings {
      :custom_only true
      :list [
        {
          :key [ "<Left>" ]
          :cb (tree_cb "prev_sibling")
        }
        {
          :key [ "<Right>" ]
          :cb (tree_cb "next_sibling")
        }

        {
          :key [ "<2-leftmouse>" "e" "<CR>" "o" ]
          :cb (tree_cb "edit")
        }
        {
          :key [ "d" ]
          :cb (tree_cb "remove")
        }
        {
          :key "h"
          :cb (tree_cb "close_node")
        }
        {
          :key "v"
          :cb (tree_cb "vsplit")
        }
        {
          :key "n"
          :cb (tree_cb "create")
        }
        {
          :key [ "r" "m" ]
          :cb (tree_cb "rename")
        }
        { 
          :key [ "<C-r>"]
          :cb (tree_cb "full_rename")
        }
        { 
          :key [ "y"]
          :cb (tree_cb "copy_name")
        }
        { 
          :key [ "Y"]
          :cb (tree_cb "copy_path")
        }

      ]
    }
    :width 30
  }
  :diagnostics {
    :icons {
      :info ""
      :warning ""
      :error ""
      :hint ""
    }
    :enable true
    :show_on_dirs true
  }
  :renderer {
    :root_folder_modifier ":t"
    :icons {
      :glyphs {
        :git {
          :unmerged ""
          :unstaged ""
          :staged "S"
          :untracked "U"
          :deleted ""
          :renamed "➜"
          :ignored "◌"
        }
        :default ""
        :symlink ""
        :folder {
          :empty ""
          :arrow_closed ""
          :symlink_open ""
          :arrow_open ""
          :empty_open ""
          :default ""
          :symlink ""
          :open ""
        }
      }
    }
  }
  :update_focused_file {
    :enable true
    :update_cwd true
  }
})
