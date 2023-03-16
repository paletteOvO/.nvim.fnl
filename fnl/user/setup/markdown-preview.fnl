(vim.cmd "function OpenMarkdownPreview (url)
   execute \"silent ! /home/shironya/Programs/waterfox/waterfox-bin --new-window \" . a:url
endfunction
  let g:mkdp_browserfunc = 'OpenMarkdownPreview'
")
(set vim.g.mkdp_auto_start 1)
