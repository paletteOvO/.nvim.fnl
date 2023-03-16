(import-macros { : autocmd! } :user.macros.autocmd)
(import-macros { : require-as! } :user.macros.require)

;; Auto compile packer plugins.fnl
(autocmd! "BufWritePost" {
   :pattern "plugins"
   :callback (lambda []
      (vim.cmd "PackerCompile"))})

;; Use 'q' to quit from common plugins
(autocmd! "FileType" {
      :pattern ["notify" "startuptime" "qf" "help" "man" "lspinfo" "spectre_panel" "lir"]
      :callback (lambda []
               (vim.cmd "nnoremap <silent> <buffer> q :close<CR>
                                  set nobuflisted"
                        )
            )
   })

;; Fixes Autocomment
(autocmd! "BufWinEnter"
   (vim.cmd "set formatoptions-=cro")
)

;; Set to normal mode when entering NvimTree
(autocmd! "WinEnter" {
   :pattern "*"
   :callback (lambda [] 
      (if (or 
            (= vim.bo.filetype "NvimTree")
            (= vim.bo.filetype "minimap")
         )
          (vim.cmd "stopinsert")
       )
   )
})

;; Highlight Yanked Text
;; (autocmd! "TextYankPost"
;;    (vim.highlight.on_yank {
;;       :higroup "Visual"
;;       :timeout 200
;;    })
;; )

(vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

;; Remove statusline and tabline when in Alpha
(autocmd! "User" {
          :pattern [ "AlphaReady"]
          :callback (lambda []
                      (vim.cmd "set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
                               set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3"))})


;; Set wrap and spell in markdown and gitcommit
(autocmd! "FileType" {
          :pattern [ "gitcommit" "markdown"]
          :callback (lambda []
                      (set vim.opt_local.wrap true)
                      (set vim.opt_local.spell true))})


(autocmd! "BufWritePre" {
          ;; group = "lsp_format_on_save",
          :pattern []
          :callback (lambda []
                      (vim.lsp.buf.format)
                      )
          })
