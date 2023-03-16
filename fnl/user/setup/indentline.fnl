(import-macros { : require-as! } :user.macros.require)

(set vim.opt.list true)
(vim.opt.listchars:append "eol:↴")
(vim.opt.listchars:append "space: ")
(vim.opt.listchars:append "trail:⋅")

(require-as! indent_blankline :indent_blankline)
(indent_blankline.setup {
   :show_end_of_line true
   ;; :space_char_blankline "⋅"
   ;; :space_char_blankline ""
   :show_current_context true
   :char "▏"
   :show_trailing_blankline_indent true
   :show_first_indent_level true
   :use_treesitter true
   :buftype_exclude [ "terminal" "nofile" ]
   :filetype_exclude [
      "help"
      "packer"
      "NvimTree"
      "alpha"
   ]
   :char_highlight_list [
      "IndentBlanklineIndent1"
      "IndentBlanklineIndent2"
      "IndentBlanklineIndent3"
      "IndentBlanklineIndent4"
      "IndentBlanklineIndent5"
      "IndentBlanklineIndent6"
   ]
})
