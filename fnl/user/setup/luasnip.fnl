(import-macros { : require-as! } :user.macros.require)

(require-as! luasnip :luasnip)

(require-as! vscode_loader :luasnip.loaders.from_vscode)

(vscode_loader.load {
   :path [ "./snippet" ]
})
