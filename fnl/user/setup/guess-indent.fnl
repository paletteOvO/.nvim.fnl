(import-macros { : require-as! } :user.macros.require)

;; Setup nvim-cmp
(require-as! guess-indent :guess-indent)
(guess-indent.setup {
   :auto_cmd true
})

