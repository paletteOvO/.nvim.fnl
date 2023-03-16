(import-macros { : require-as! } :user.macros.require)

(_G.logger:info "Loading colorscheme")

(require-as! cat :catppuccin)

(set vim.g.catppuccin_flavour "latte")
;; (set vim.g.catppuccin_flavour "mocha")
(require-as! catppuccin_palettes "catppuccin.palettes")

(local colors ((. (require "catppuccin.palettes") :get_palette)))
(local C colors)
(cat.setup {
   :compile {
      :enabled true
      :path (.. (vim.fn.stdpath "cache") "/catppuccin")
   }
   :custom_highlights {
		:Comment { :fg colors.overlay1 }
		:LineNr { :fg colors.overlay1 }
		:CursorLine { :bg colors.none }
		:CursorLineNr { :fg colors.lavender }
		:DiagnosticVirtualTextError { :bg colors.none }
		:DiagnosticVirtualTextWarn { :bg colors.none }
		:DiagnosticVirtualTextInfo { :bg colors.none }
		:DiagnosticVirtualTextHint { :bg colors.none }
      :CmpItemKindSnippet { :fg C.base :bg C.mauve }
      :CmpItemKindKeyword { :fg C.base :bg C.red }
      :CmpItemKindText { :fg C.base :bg C.teal }
      :CmpItemKindMethod { :fg C.base :bg C.blue }
      :CmpItemKindConstructor { :fg C.base :bg C.blue }
      :CmpItemKindFunction { :fg C.base :bg C.blue }
      :CmpItemKindFolder { :fg C.base :bg C.blue }
      :CmpItemKindModule { :fg C.base :bg C.blue }
      :CmpItemKindConstant { :fg C.base :bg C.peach }
      :CmpItemKindField { :fg C.base :bg C.green }
      :CmpItemKindProperty { :fg C.base :bg C.green }
      :CmpItemKindEnum { :fg C.base :bg C.green }
      :CmpItemKindUnit { :fg C.base :bg C.green }
      :CmpItemKindClass { :fg C.base :bg C.yellow }
      :CmpItemKindVariable { :fg C.base :bg C.flamingo }
      :CmpItemKindFile { :fg C.base :bg C.blue }
      :CmpItemKindInterface { :fg C.base :bg C.yellow }
      :CmpItemKindColor { :fg C.base :bg C.red }
      :CmpItemKindReference { :fg C.base :bg C.red }
      :CmpItemKindEnumMember { :fg C.base :bg C.red }
      :CmpItemKindStruct { :fg C.base :bg C.blue }
      :CmpItemKindValue { :fg C.base :bg C.peach }
      :CmpItemKindEvent { :fg C.base :bg C.blue }
      :CmpItemKindOperator { :fg C.base :bg C.blue }
      :CmpItemKindTypeParameter { :fg C.base :bg C.blue }
      :CmpItemKindCopilot { :fg C.base :bg C.teal }
	}
   :transparent_background true
   :term_colors true
   :styles {
	   :comments ["italic"]
	   :conditionals ["italic"]
	   :loops []
	   :functions []
	   :keywords []
	   :strings []
	   :variables []
	   :numbers []
	   :booleans []
	   :properties []
	   :types []
	   :operators []
   }
   :integrations {
      :notify true
      :which_key true
      :indent_blankline {
         :enabled true
         :colored_indent_levels true
      }
      :nvimtree {
         :enabled true
         :show_root true
         :transparent_panel false
      }
      :neotree {
         :enabled true
      }
      :cmp true
      :gitsigns true
      :telescope true
      :native_lsp {
         :enabled true
      }
      :neogit true
      :ts_rainbow true
      :hop true
      :bufferline true
   }
})

(pcall vim.cmd "colorscheme catppuccin")
