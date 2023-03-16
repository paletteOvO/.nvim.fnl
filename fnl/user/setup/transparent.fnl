
(import-macros { : require-as! } :user.macros.require)

(require-as! transparent :transparent)

(transparent.setup {
   :enable true
   :extra_groups [
      "BufferLineTabClose"
      "BufferlineBufferSelected"
      "BufferLineFill"
      "BufferLineBackground"
      "BufferlineSeparator"
      "BufferLineIndicatorSelected"
   ]
})

