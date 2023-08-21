(import-macros { : require-as! } :user.macros.require)

(require-as! lspkind :lspkind)

(lspkind.init {
   :symbol_map {
      :Text ""
      :Method ""
      :Function ""
      :Constructor ""
      :Field "ﰠ"
      :Variable ""
      :Class "ﴯ"
      :Interface ""
      :Module ""
      :Property "ﰠ"
      :Unit "塞"
      :Value ""
      :Enum ""
      :Keyword ""
      :Snippet ""
      :Color ""
      :File ""
      :Reference ""
      :Folder ""
      :EnumMember ""
      :Constant ""
      :Struct "פּ"
      :Event ""
      :Operator ""
      :TypeParameter "󰰤"
      :Copilot ""
      :TabNine "󰋙"
   }   
})
