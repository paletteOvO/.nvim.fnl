(import-macros { : require-as! } :user.macros.require)

(require-as! indent-o-matic :indent-o-matic)

(indent-o-matic.setup {
   :max_lines 256
   :standard_widths [3 2 4 8]
   :skip_multiline true
})
