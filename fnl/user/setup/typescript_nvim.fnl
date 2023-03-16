(import-macros { : require-as! } :user.macros.require)

(require-as! ts :typescript)

(ts.setup {
   :debug false
})
