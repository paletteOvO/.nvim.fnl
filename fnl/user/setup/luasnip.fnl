(import-macros { : require-as! } :user.macros.require)

(require-as! luasnip :luasnip)

(vim.schedule (lambda []
   (require-as! vscode_loader :luasnip.loaders.from_vscode)
   (vscode_loader.load {
      :path [ "./snippet" ]
   })
))

