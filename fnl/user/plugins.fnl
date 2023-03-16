(import-macros { : require-as! } :user.macros.require)
(import-macros { : use! : use-rocks! : setup! : lite-setup! : lazy-startup! } :user.macros.package)

;; Use a protected call so we don't error out on first use
(local (status_ok lazy) (pcall require :lazy))
(if (not status_ok)
   (lua "return")
)

(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

(set vim.g.mapleader " ")

;; Have packer use a popup window
; (packer.init {
;    :display {
;       :open_fn (lambda [] ((. (require "packer.util") :float) {
;          :border "single"
;       }))
;    }
;    :autoremove true
; })

;; Install your plugins here
(lazy-startup!
   ;; (use-rocks! "fun")

   (use! "folke/lazy.nvim")
   (use! "rktjmp/hotpot.nvim")
   (use! "Tastyep/structlog.nvim" {
      :pin true
      :commit "6f1403a192791ff1fa7ac845a73de9e860f781f1"
   })

   (use! "dstein64/vim-startuptime" {
      :cmd [ "StartupTime" ]
   })

   (use! "antoinemadec/FixCursorHold.nvim") ;; Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

   (use! "wbthomason/packer.nvim") ;; Have packer manage itself
   ; (use! "rktjmp/hotpot.nvim") ;; .fnl
   (use! "max397574/which-key.nvim")



   (use! "nvim-lua/popup.nvim")
   (use! "nvim-lua/plenary.nvim") ;; Useful lua functions used by lots of plugins
   (use! "rcarriga/nvim-notify" {
      :requires [ "nvim-telescope/telescope.nvim" ]
      :config (setup! :notify)
   })
   (use! "stevearc/dressing.nvim" {
      :config (setup! :dressing)
   })
   ;; (use! "junegunn/fzf")
   ;; (use! "ibhagwan/fzf-lua")

   (use! "eraserhd/parinfer-rust" {
      :build "cargo build --release"
      :config (lambda []
         (set vim.g.parinfer_mode "paren")
      )
      :cmd [ "ParinferOn" ]
   })

   (use! "guns/vim-sexp")
   (use! "tpope/vim-sexp-mappings-for-regular-people")
   (use! "windwp/nvim-autopairs" {
      :config (setup! :autopairs)
   }) ;; Autopairs, integrates with both cmp and treesitter
   (use! "numToStr/Comment.nvim" {
         :config (setup! :comment)
   })
   ;; (use! "Olical/conjure" {
   ;;    :branch "develop"
   ;;    :ft lisp-ft
   ;;    :requires ["rktjmp/hotpot.nvim"]
   ;; })

   ;; Nvim-tree
   (use! "kyazdani42/nvim-tree.lua" {
      :config (setup! :nvim-tree)
      :cmd [ "NvimTreeToggle" ]
   })
   (use! "kyazdani42/nvim-web-devicons" {
   })

   (use! "akinsho/bufferline.nvim" {
      :event "BufNew"
      :config (setup! :bufferline)
   })
   (use! "nvim-lualine/lualine.nvim"
      {
         :event "BufNew"
         :config (setup! :lualine)
      }
   )
   (use! "tiagovla/scope.nvim" {
      :event "BufNew"
      :config (setup! :scope)
   })

   (use! "moll/vim-bbye")
   (use! "ahmedkhalf/project.nvim" {
      :config (setup! :project)
   })
   (use! "lukas-reineke/indent-blankline.nvim" {
      :event "BufNew"
      :config (setup! :indentline)
   })
   (use! "goolord/alpha-nvim" {
      ;; :after ["indent-blankline.nvim" "bufferline.nvim"]
      ;; :event "VimEnter"
      ;; :config (setup! :alpha)
   })

   ;; Colorschemes
   ;; (use! "folke/tokyonight.nvim")
   ;; (use! "lunarvim/onedarker.nvim")
   ;; (use! "lunarvim/darkplus.nvim")
   (use! "catppuccin/nvim" {
      :as "catppuccin"
      :build (lambda [] (let
         [cat (require "catppuccin")]
         (cat.compile)
      ))
   })
   (use! "folke/lsp-colors.nvim" {
      :config (setup! :lsp-colors)
   })

   ;; cmp plugins
   (use! "hrsh7th/nvim-cmp")
   (use! "hrsh7th/cmp-buffer")
   (use! "tzachar/fuzzy.nvim" {
      :requires ["nvim-telescope/telescope-fzf-native.nvim"]
   })
   (use! "tzachar/cmp-fuzzy-buffer" {
      :requires ["tzachar/fuzzy.nvim"]
   })
   (use! "hrsh7th/cmp-path")
   (use! "hrsh7th/cmp-nvim-lsp")
   (use! "hrsh7th/cmp-nvim-lua")
   (use! "saadparwaiz1/cmp_luasnip")
   (use! "onsails/lspkind.nvim")

   ;; (use! "github/copilot.vim") ;; for setup copilot
   (use! "zbirenbaum/copilot.lua" {
      :event "BufNew"
      :config (setup! :copilot)
   })
   (use! "zbirenbaum/copilot-cmp" {
      :module "copilot_cmp"
      :after [
         "copilot.lua"
         "nvim-cmp"
      ]
   })

   ;; snippets
   (use! "L3MON4D3/LuaSnip" {
      :config (setup! :luasnip)
   })

   (use! "rafamadriz/friendly-snippets" {
      :event "BufNew"
   })
   ;; (use! "folke/lua-dev.nvim") ;; we don't use lua anyway

   ;; LSP
   (use! "neovim/nvim-lspconfig") ;; enable LSP
   ;; (use! "williamboman/nvim-lsp-installer") ;; simple to use language server installer
   (use! "williamboman/mason.nvim" {
      ;; :config (setup! :mason)
   })
   (use! "williamboman/mason-lspconfig")
   ;; for formatters and linters
   (use! "jose-elias-alvarez/null-ls.nvim" {
   })
   ; (use! "VonHeikemen/lsp-zero.nvim" {
   ;    :branch "v2.x"
   ; })
   (use! "RRethy/vim-illuminate" {
      :config (setup! :illuminate)
   })
   (use! "kevinhwang91/promise-async")
   (use! "kevinhwang91/nvim-ufo" {
      :requires ["kevinhwang91/promise-async"]
      :config (setup! :ufo)
   })
   (use! "kosayoda/nvim-lightbulb" {
      :config (setup! :lightbulb)
   })
   (use! "lewis6991/hover.nvim" {
      :config (setup! :hover)
   })
   ;; (use! "/home/shironya/.config/nvim/lsp_lines.nvim" {
   ;;    :config (setup! :lsp_lines)
   ;; })
   (use! "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {
      :config (setup! :lsp_lines)
   })
   (use! "lvimuser/lsp-inlayhints.nvim" {
      :config (lite-setup! :lsp-inlayhints {
         :labels_separator " // "
      })
   })
   (use! "j-hui/fidget.nvim" {
      :config (setup! :fidget)
   })
   ;; (use! "anuvyklack/nvim-keymap-amend")
   ;; (use! "anuvyklack/pretty-fold.nvim" {
   ;;    :require ["anuvyklack/nvim-keymap-amend"]
   ;;    :config (setup! :pretty-fold)
   ;; })
   (use! "jose-elias-alvarez/typescript.nvim" {
      :config (setup! :typescript_nvim)
   })
   (use! "folke/trouble.nvim" {
      :config (setup! :trouble)
   })
   (use! "weilbith/nvim-code-action-menu" {
      :cmd "CodeActionMenu"
   })

   ;; lsp lang

   (use! "simrat39/rust-tools.nvim" {
      :config (setup! :rust-tools)
   })
   (use! "mfussenegger/nvim-jdtls" {})

   ;; other lang
   (use! "lervag/vimtex" {
      :config (setup! :vimtex)
   })

   ;; Telescope
   (use! "nvim-telescope/telescope.nvim" {
      :config (setup! :telescope)
   })
   (use! "nvim-telescope/telescope-fzf-native.nvim" {
      :build "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
   })

   ;; Treesitter/Highlighting
   (use! "nvim-treesitter/nvim-treesitter" {
      :build ":TSUpdate"
      :as "nvim-treesitter"
      :config (setup! :treesitter)
   })
   (use! "p00f/nvim-ts-rainbow" {
      :after ["nvim-treesitter"]
   })
   (use! "JoosepAlviste/nvim-ts-context-commentstring" {
      :after ["nvim-treesitter"]
   })

   (use! "nvim-treesitter/nvim-treesitter-context")
   (use! "nvim-treesitter/nvim-treesitter-textobjects")
   (use! "ziontee113/syntax-tree-surfer")

   (use! "monkoose/matchparen.nvim" {
      :config (setup! :matchparen)
   })
   (use! "kylechui/nvim-surround")
   (use! "rrethy/vim-hexokinase" {
      :build "make hexokinase"
      :event "BufNew"
      :config (lambda [] (set vim.g.Hexokinase_highlighters [ "backgroundfull" "virtual" ]))
   })
   (use! "windwp/nvim-ts-autotag" {
      :ft ["html" "javascript" "typescript" "javascriptreact" "typescriptreact" "svelte" "vue" "tsx" "jsx" "rescript"
           "xml"
           "php"
           "markdown"
           "glimmer" "handlebars" "hbs"]
      :config (lambda [] (local x (require :nvim-ts-autotag)) (x.setup))
   })
   (use! "IndianBoy42/tree-sitter-just" {
      :ft ["just"]
      :config (lambda [] (local x (require :tree-sitter-just)) (x.setup {}))
   })

   ;; formatters
   (use! "wesleimp/stylua.nvim")
   ;; (use! "NMAC427/guess-indent.nvim" {
   ;;    :config (setup! :guess-indent)
   ;; })
   (use! "Darazaki/indent-o-matic" {
      :config (setup! :indent-o-matic)
   })


   ;; git
   (use! "lewis6991/gitsigns.nvim" {
      :event "BufNew"
      :config (setup! :gitsigns)
   })

   (use! "sindrets/diffview.nvim" {
      :event "BufNew"
   })

   ;; Nav
   (use! "phaazon/hop.nvim" {
      :event "BufNew"
      :config (setup! :hop)
   })
   (use! "nacro90/numb.nvim" {
      :event "BufNew"
      :config (setup! :numb)
      :centered_peeking true
   })
   (use! "karb94/neoscroll.nvim" {
      :config (setup! :neoscroll)
   })
   ;; (use! "wfxr/minimap.vim" {
   ;;    :run "cargo install code-minimap"
   ;;    :event "BufRead"
   ;;    :config (setup! :minimap)
   ;; })

   ;; DAP
   (use! "mfussenegger/nvim-dap" {
      :cmd ["DAPEnable"]
      :config (setup! :dap)
   })
   (use! "rcarriga/nvim-dap-ui" {
      :cmd ["DAPEnable"]
      :config (setup! :dap)
   })
   (use! "Pocco81/dap-buddy.nvim" {
      :cmd ["DAPEnable"]
      :config (setup! :dap)
   })

   ;; Markdown
   (use! "iamcco/markdown-preview.nvim" {
      :ft ["markdown" "md"]
      :config (setup! :markdown-preview)
      :build (lambda []
         ((. vim.fn "mkdp#util#install"))
      )
   })
   ;; (n)org
   (use! "nvim-neorg/neorg" {
      :ft ["norg"]
      :after ["nvim-treesitter"]
      :config (setup! :neorg)
   })
   (use! "nvim-orgmode/orgmode" {
      :ft ["org"]
      :after ["nvim-treesitter"]
      :config (setup! :orgmode)
   })
   ;; Misc

   ;; (use! "Pocco81/TrueZen.nvim" {
   ;;    :cmd [ "TZMinimalist" "TZFocus" "TZAtaraxis" "TZAtaraxisOn" "TZMinimalistOn" "TZFocusOn" ]
   ;;    :config (setup! :true_zen)
   ;; })

   (use! "max397574/better-escape.nvim" {
      :config (setup! :better-escape)
   })
   (use! "xiyaowong/nvim-transparent" {
      :config (setup! :transparent)
   })

   ;; (use! "Pocco81/auto-save.nvim" {
   ;;    :event "BufRead"
   ;;    :config (setup! :autosave)
   ;; })
   (use! "b0o/schemastore.nvim")
   (use! "ellisonleao/glow.nvim" {
   })
   (use! "CRAG666/code_runner.nvim" {
      :requires "nvim-lua/plenary.nvim"
      :config (setup! :code_runner)
   })

   (opts {
      :defaults {
         :lazy false
      }
   })

   ; (require-as! packer :packer)

   ; (packer.compile)

   ; (if (. vim.g "nya#bootstrap" "wbthomason/packer.nvim")
   ;    (do
   ;       (print "PackerSync")
   ;       (packer.sync)
   ;    )
   ; )
)
