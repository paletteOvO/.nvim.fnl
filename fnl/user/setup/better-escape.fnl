(import-macros { : require-as! } :user.macros.require)

(require-as! besc :better_escape)

(besc.setup {
   :mapping ["jk"]
   :timeout 100
   :keys "<ESC>"
})
