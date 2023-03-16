local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
   return
end

local servers = {
   "lua_ls",
   "cssls",
   "html",
   "tsserver",
   "pyright",
   "bashls",
   "jsonls",
   "yamlls",
   "emmet_ls",
   "rust_analyzer",
   "texlab",
   "jdtls",
   "fennel_language_server",
}

lsp_installer.setup()

require("mason-lspconfig").setup({ automatic_installation = true })

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

   lspconfig[server].setup(opts)
end
