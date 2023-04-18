local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
   return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
   return
end

local compare = require("cmp.config.compare")

require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
   },

   mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<Esc>"] = cmp.mapping.abort(),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
         if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
               cmp.confirm()
            else
               cmp.confirm()
            end
         else
            fallback()
         end
      end, { "i" }),
   }),

   sources = {
      { name = "copilot", priority_weight = 100 },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip", priority_weight = 50, max_item_count = 2 },
      -- { name = "buffer" },
      -- { name = "path" },
      {
         name = "fuzzy_buffer",
         max_item_count = 4,
         priority_weight = 12,
         option = {
            max_matches = 5,
            get_bufnrs = function()
               local bufs = {}
               for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                  local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
                  if buftype ~= "nofile" and buftype ~= "prompt" then
                     bufs[#bufs + 1] = buf
                  end
               end
               return bufs
            end,
         },
      },
      { name = "fuzzy_path", priority_weight = 25, max_item_count = 2 },
   },
   sorting = {
      priority_weight = 2,
      comparators = {
         require("cmp_fuzzy_buffer.compare"),
         compare.offset,
         compare.exact,
         compare.score,
         compare.recently_used,
         compare.kind,
         compare.sort_text,
         compare.length,
         compare.order,
      },
   },
   confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
   },
   window = {
      completion = {
         -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
         winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:None",
         col_offset = -3,
         side_padding = 0,
      },
   },
   formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
         local kind = require("lspkind").cmp_format({ mode = "symbol_text" })(entry, vim_item)
         local strings = vim.split(kind.kind, "%s", { trimempty = true })

         kind.menu = " (" .. (strings[2] or string.gsub(kind.kind, "^%s*(.-)%s*$", "%1")) .. ")"
         kind.kind = " " .. (strings[1] or "") .. " "

         return kind
      end,
   },
   experimental = {
      ghost_text = true,
   },
})
