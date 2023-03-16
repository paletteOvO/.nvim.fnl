(import-macros { : autocmd! } :user.macros.autocmd)

(set vim.g.minimap_block_filetypes [
   "help"
   "NvimTree"
   "alpha"
   "fugitive"
   "nerdtree"
   "tagbar"
   "fzf"
   "minimap"
])

(autocmd! "BufNew" {
   :callback (lambda []
      (vim.schedule (lambda [] (vim.cmd "Minimap")))
   )
})
