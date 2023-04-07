
(import-macros { : require-as! } :user.macros.require)

(require-as! transparent :transparent)

(transparent.setup {
   :extra_groups [
      "BufferLineTabClose"
      "BufferlineBufferSelected"
      "BufferLineFill"
      "BufferLineBackground"
      "BufferlineSeparator"
      "BufferLineIndicatorSelected"
   ]
})

