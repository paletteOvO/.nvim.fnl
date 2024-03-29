local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
   return
end

local servers = {
   "lua_ls",
   "cssls",
   "html",
   "tsserver",
   "ruff_lsp",
   "ruby_ls",
   "crystalline",
   "solargraph",
   "bashls",
   "jsonls",
   "yamlls",
   "emmet_ls",
   "rust_analyzer",
   "texlab",
   "jdtls",
   "fennel_language_server",
   "zls",
   "tailwindcss",
   "jsonls",
}

lsp_installer.setup()

require("mason-lspconfig").setup({ ensure_installed = servers,  automatic_installation = true })

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
   return
end

local opts = {}

for _, server in pairs(servers) do
   opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      flags = require("user.lsp.handlers").flags,
   }

   local existed, custom_opts = pcall(require, "user.lsp.settings." .. server)
   if existed then
      opts = vim.tbl_deep_extend("force", custom_opts, opts)
   end

   logger:info("setting up " .. server)

   -- skip rust as it's handled by rust-tools.nvim
   if server == "rust_analyzer" then
      logger:info("skipping rust_analyzer")
   else
      lspconfig[server].setup(opts)
   end


end




