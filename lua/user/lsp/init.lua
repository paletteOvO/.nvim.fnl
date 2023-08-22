local status_ok, _ = pcall(require, "mason-lspconfig")
if not status_ok then
   return
end

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

-- vim.api.nvim_create_autocmd("InsertEnter", {
--    callback = function()
--       vim.diagnostic.hide()
--    end,
-- })
--
-- vim.api.nvim_create_autocmd("ModeChanged", {
--    pattern = "i:*",
--    callback = function()
--       vim.diagnostic.show()
--    end,
-- })

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
   group = "LspAttach_inlayhints",
   callback = function(args)
      if not (args.data and args.data.client_id) then
         return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      require("lsp-inlayhints").on_attach(client, bufnr)

      vim.cmd("hi clear LspInlayHint")
      vim.cmd("hi link LspInlayHint Comment")
   end,
})

local status_ok, ufo = pcall(require, "ufo")
if status_ok then
   ufo.setup()
end
