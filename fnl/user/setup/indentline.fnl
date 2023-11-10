(import-macros { : require-as! } :user.macros.require)

(set vim.opt.list true)
(vim.opt.listchars:append "eol:↴")
(vim.opt.listchars:append "space: ")
(vim.opt.listchars:append "trail:⋅")

(require-as! ibl :ibl)

(local highlight [
   :RainbowRed
   :RainbowOrange
   :RainbowYellow
   :RainbowGreen
   :RainbowCyan
   :RainbowBlue
   :RainbowViolet
])

(local hooks (require "ibl.hooks"))

(hooks.register hooks.type.HIGHLIGHT_SETUP (lambda []
   (vim.api.nvim_set_hl 0 "RainbowRed" { :fg "#E06C75" })
   (vim.api.nvim_set_hl 0 "RainbowOrange" { :fg "#D19A66" })
   (vim.api.nvim_set_hl 0 "RainbowYellow" { :fg "#E5C07B" })
   (vim.api.nvim_set_hl 0 "RainbowGreen" { :fg "#98C379" })
   (vim.api.nvim_set_hl 0 "RainbowCyan" { :fg "#56B6C2" })
   (vim.api.nvim_set_hl 0 "RainbowBlue" { :fg "#61AFEF" })
   (vim.api.nvim_set_hl 0 "RainbowViolet" { :fg "#C678DD" })
))

(tset vim.g :rainbow_delimiters { :highlight highlight })

(ibl.setup {
   :exclude {
      :filetypes [ "help" "packer" "NvimTree" "alpha" ]
      :buftypes [ "terminal" "nofile" ]
   }
   :indent {
      :highlight highlight
   }
   :scope {
      :highlight highlight
   }
   :whitespace {
      
   }
})

(hooks.register hooks.type.SCOPE_HIGHLIGHT hooks.builtin.scope_highlight_from_extmark)
