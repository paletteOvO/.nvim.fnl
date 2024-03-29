local M = {}

M.setup = function()
   local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
   }

   for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
   end

   local config = {
      virtual_text = {
         -- severity = { min = 0, max = 0 },
      },
      -- virtual_lines = true,
      signs = {
         active = signs, -- show signs
      },
      update_in_insert = true, -- false,
      underline = true,
      severity_sort = true,
      float = {
         focusable = true,
         style = "minimal",
         border = "single",
         source = "always",
         header = "",
         prefix = "",
      },
   }

   vim.diagnostic.config(config)

   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
   })

   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
   })
end

local function lsp_keymaps(bufnr)
   local opts = { noremap = true, silent = true }
   local keymap = vim.api.nvim_buf_set_keymap
   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   -- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
   keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
   keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
   keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
   keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
   keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
   keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
   keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
   keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
   logger:info(client.name .. " attached")

   local caps = client.server_capabilities

   if client.name == "tsserver" then
      caps.documentFormattingProvider = false
      caps.diagnosticProvider = false
      client.handlers["textDocument/publishDiagnostics"] = function() end
   end

   if client.name == "lua_ls" then
      caps.documentFormattingProvider = false
   end

   if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
      local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
      vim.api.nvim_create_autocmd("TextChanged", {
         group = augroup,
         buffer = bufnr,
         callback = function()
            vim.treesitter.stop(bufnr)
            vim.lsp.buf.semantic_tokens_full()
         end,
      })
      -- fire it first time on load as well

      vim.treesitter.stop(bufnr)
      vim.lsp.buf.semantic_tokens_full()
   end

   -- lsp_keymaps(bufnr)
   local status_ok, illuminate = pcall(require, "illuminate")
   if status_ok then
      illuminate.on_attach(client)
   end
   --
   local status_ok, lsp_signature = pcall(require, "lsp_signature")
   if status_ok then
      lsp_signature.on_attach()
      logger:info("lsp_signature on_attach")
   end

   local status_ok, lsp_zero = pcall(require, "lsp-zero")
   if status_ok then
      lsp_zero.preset({}).default_keymaps({ buffer = bufnr })
   end
end

M.flags = {
   debounce_text_changes = 180,
}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
   M.capabilities.textDocument.completion.completionItem.snippetSupport = true
   M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
end

local status_ok, _ufo = pcall(require, "ufo")
if status_ok then
   M.capabilities.textDocument.foldingRange = {}
   M.capabilities.textDocument.foldingRange.dynamicRegistration = false
   M.capabilities.textDocument.foldingRange.lineFoldingOnly = true
end

return M
