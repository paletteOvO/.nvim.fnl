local lspconfig = require("lspconfig")
return {
   autostart = true,
   root_dir = lspconfig.util.root_pattern("fnl"),
   settings = {
      fennel = {
         workspace = {
            -- If you are using hotpot.nvim or aniseed,
            -- make the server aware of neovim runtime files.
            library = vim.api.nvim_list_runtime_paths(),
         },
         diagnostics = {
            globals = { "vim" },
         },
      },
   },
}
