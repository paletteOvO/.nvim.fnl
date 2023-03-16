(import-macros { : require-as! } :user.macros.require)

(require-as! ufo :ufo)
(require-as! lspconfig :lspconfig)

(local capabilities (vim.lsp.protocol.make_client_capabilities))

(set vim.wo.foldcolumn "1")
(set vim.wo.foldlevel 99)
(set vim.wo.foldenable true)

(set capabilities.textDocument.foldingRange {
    :dynamicRegistration false
    :lineFoldingOnly true
})

(lambda map [tbl cb]
   (local _t [])
   (each [i v (ipairs tbl)]
      (table.insert _t (cb v i))
   )
   _t
)

(local language_servers (do 
   (require-as! lsp_installer "mason-lspconfig")
   (local srv (lsp_installer.get_installed_servers))
   (map srv (lambda [x] (. x :name)))
))

(each [i v (ipairs language_servers)]
   ((. lspconfig v :setup) {
      :capabilities capabilities
   })
   (logger:info "setting %s" v)
)

(ufo.setup)
