(import-macros { : require-as! } :user.macros.require)

(require-as! bufferline :bufferline)

(bufferline.setup {
   :options {
      :right_mouse_command "Bdelete! %d"
      :left_mouse_command "buffer %d"
      :offsets [
         {
            :text (lambda [] (string.gsub (vim.fn.getcwd) "/home/shironya" "~"))
            :padding 0
            :text_align "left"
            :filetype "NvimTree"
            :highlight "Directory"
         }
      ]
      :close_command "Bdelete! %d"
      :buffer_close_icon ""
      :modified_icon ""
      :close_icon ""
      :show_close_icon false
      :left_trunc_marker ""
      :right_trunc_marker ""
      :max_name_length 14
      :max_prefix_length 13
      :tab_size 10
      :show_tab_indicators true
      :enforce_regular_tabs false
      :view "multiwindow"
      :show_buffer_close_icons true
      :separator_style [" " " "]
      :indicator { :style "icon" :icon " " }
      :always_show_bufferline true
      :diagnostics true
      :themable true
   }
})
