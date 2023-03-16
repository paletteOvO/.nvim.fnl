(lambda autocmd! [event opts ...]
   (if (table? opts)
      `(vim.api.nvim_create_autocmd [ ,event ] ,opts)
      `(vim.api.nvim_create_autocmd [ ,event ] {
         :callback (lambda [] ,opts ,...)
      })
   )
)

{ : autocmd! }
