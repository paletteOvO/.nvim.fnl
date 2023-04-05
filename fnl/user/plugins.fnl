(import-macros { : require-as! } :user.macros.require)
(import-macros { : use! : use-rocks! : setup! : lite-setup! : lazy-startup! } :user.macros.package)

;; Use a protected call so we don't error out on first use
(local (status_ok _lazy) (pcall require :lazy))
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

   ; (use! "wbthomason/packer.nvim") ;; Have packer manage itself
   (use! "folke/lazy.nvim")
   (use! "rktjmp/hotpot.nvim")
   (use! "Tastyep/structlog.nvim" {
      :pin true
      :commit "6f1403a192791ff1fa7ac845a73de9e860f781f1"
   })

   ; (use! "dstein64/vim-startuptime" {
   ;    :cmd [ "StartupTime" ]
   ; })

   (use! "antoinemadec/FixCursorHold.nvim") ;; Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

   (use! "max397574/which-key.nvim")

   (use! "nvim-lua/popup.nvim")
   (use! "nvim-lua/plenary.nvim") ;; Useful lua functions used by lots of plugins
   (use! "rcarriga/nvim-notify" {
      :event "User AlphaLeave"
      :dependencies [ "nvim-telescope/telescope.nvim" ]
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

   (use! "guns/vim-sexp" {
      :ft lisp-ft
   })
   (use! "tpope/vim-sexp-mappings-for-regular-people" {
      :ft lisp-ft
   })

   (use! "windwp/nvim-autopairs" {
      :config (setup! :autopairs)
   }) ;; Autopairs, integrates with both cmp and treesitter
   (use! "numToStr/Comment.nvim" {
      :event "User AlphaLeave"
      :config (setup! :comment)
   })
   ;; (use! "Olical/conjure" {
   ;;    :branch "develop"
   ;;    :ft lisp-ft
   ;;    :requires ["rktjmp/hotpot.nvim"]
   ;; })

   ;; Nvim-tree
   ; (use! "kyazdani42/nvim-tree.lua" {
   ;    :config (setup! :nvim-tree)
   ;    :cmd [ "NvimTreeToggle" ]
   ; })
   (use! "MunifTanjim/nui.nvim")

   (use! "nvim-neo-tree/neo-tree.nvim" {
      :branch "v2.x"
      :config (setup! :neotree)
      :cmd [ "Neotree" "NeoTreeShowToggle" ]
      ; :event "User AlphaLeave"
   })
   ; (use! "kyazdani42/nvim-web-devicons" {
   ; })

   ; (use! "akinsho/bufferline.nvim" {
   ;    :config (setup! :bufferline)
   ; })
   (use! "nvim-lualine/lualine.nvim" {
      :event "User AlphaLeave"
      :config (setup! :lualine)
   })
   (use! "tiagovla/scope.nvim" {
      :config (setup! :scope)
   })

   (use! "moll/vim-bbye")
   (use! "ahmedkhalf/project.nvim" {
      :event "User AlphaReady"
      :config (setup! :project)
   })
   (use! "lukas-reineke/indent-blankline.nvim" {
      :event "User AlphaLeave"
      :config (setup! :indentline)
   })
   (use! "goolord/alpha-nvim" {
      ;; :after ["indent-blankline.nvim" "bufferline.nvim"]
      ;; :config (setup! :alpha)
   })

   ;; Colorschemes
   ;; (use! "folke/tokyonight.nvim")
   ;; (use! "lunarvim/onedarker.nvim")
   ;; (use! "lunarvim/darkplus.nvim")
   (use! "catppuccin/nvim" {
      :name "catppuccin"
      :build (lambda [] (let
         [cat (require "catppuccin")]
         (cat.compile)
      ))
   })
   (use! "folke/lsp-colors.nvim" {
      :config (setup! :lsp-colors)
   })

   ;; cmp plugins
   (use! "hrsh7th/nvim-cmp" {
   })
   (use! "hrsh7th/cmp-buffer" {
   })
   (use! "tzachar/fuzzy.nvim" {
      :dependencies ["nvim-telescope/telescope-fzf-native.nvim"]
   })
   (use! "tzachar/cmp-fuzzy-buffer" {
      :dependencies ["tzachar/fuzzy.nvim"]
   })
   (use! "hrsh7th/cmp-path")
   (use! "hrsh7th/cmp-nvim-lsp")
   (use! "hrsh7th/cmp-nvim-lua")
   (use! "saadparwaiz1/cmp_luasnip")
   (use! "onsails/lspkind.nvim")

   ;; (use! "github/copilot.vim") ;; for setup copilot
   (use! "zbirenbaum/copilot.lua" {
      :config (setup! :copilot)
   })
   (use! "zbirenbaum/copilot-cmp" {
      :module "copilot_cmp"
      :dependencies [
         "copilot.lua"
         "nvim-cmp"
      ]
   })

   ;; snippets
   (use! "L3MON4D3/LuaSnip" {
      :config (setup! :luasnip)
   })

   (use! "rafamadriz/friendly-snippets" {
   })
   ;; (use! "folke/lua-dev.nvim") ;; we don't use lua anyway

   ;; LSP
   (use! "neovim/nvim-lspconfig" {
      :event "User AlphaLeave"
   }) ;; enable LSP
   ;; (use! "williamboman/nvim-lsp-installer") ;; simple to use language server installer
   (use! "williamboman/mason.nvim" {
      :cmd [ "Mason" ]
      :event "User AlphaLeave"
      ;; :config (setup! :mason)
   })
   (use! "williamboman/mason-lspconfig" {
      :cmd [ "Mason" ]
      :event "User AlphaLeave"
   })
   (use! "ray-x/lsp_signature.nvim" {
      :event "User AlphaLeave"
      :config (setup! :lsp_signature)
   })

   ;; for formatters and linters
   (use! "jose-elias-alvarez/null-ls.nvim" {
      :event "User AlphaLeave"
      :dependencies ["nvim-lspconfig"]
   })
   ; (use! "VonHeikemen/lsp-zero.nvim" {
   ;    :branch "v2.x"
   ; })
   (use! "RRethy/vim-illuminate" {
      :event "User AlphaLeave"
      :config (setup! :illuminate)
      :dependencies ["nvim-lspconfig"]
   })
   (use! "kevinhwang91/promise-async")
   (use! "kevinhwang91/nvim-ufo" {
      :event "User AlphaLeave"
      :dependencies ["kevinhwang91/promise-async"]
      :config (setup! :ufo)
   })
   (use! "kosayoda/nvim-lightbulb" {
      :event "User AlphaLeave"
      :config (setup! :lightbulb)
      :dependencies ["nvim-lspconfig"]
   })
   (use! "lewis6991/hover.nvim" {
      :event "User AlphaLeave"
      :config (setup! :hover)
      :dependencies ["nvim-lspconfig"]
   })
   ;; (use! "/home/shironya/.config/nvim/lsp_lines.nvim" {
   ;;    :config (setup! :lsp_lines)
   ;; })
   (use! "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {
      :event "User AlphaLeave"
      :dependencies ["nvim-lspconfig"]
      :config (setup! :lsp_lines)
   })
   (use! "lvimuser/lsp-inlayhints.nvim" {
      :event "User AlphaLeave"
      :dependencies ["nvim-lspconfig"]
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
      :ft ["typescript" "typescriptreact"]
      :config (setup! :typescript_nvim)
   })
   (use! "folke/trouble.nvim" {
      :event "User AlphaLeave"
      :config (setup! :trouble)
   })
   (use! "weilbith/nvim-code-action-menu" {
      :cmd "CodeActionMenu"
   })

   ;; lsp lang

   (use! "simrat39/rust-tools.nvim" {
      :ft ["rust"]
      :config (setup! :rust-tools)
   })
   (use! "mfussenegger/nvim-jdtls" {})

   ;; other lang
   (use! "lervag/vimtex" {
      :ft ["tex"]
      :config (setup! :vimtex)
   })

   ;; Telescope
   (use! "nvim-telescope/telescope.nvim" {
      :event "User AlphaReady"
      :config (setup! :telescope)
   })
   (use! "nvim-telescope/telescope-fzf-native.nvim" {
      :build "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
   })

   ;; Treesitter/Highlighting
   (use! "nvim-treesitter/nvim-treesitter" {
      :build ":TSUpdate"
      :name "nvim-treesitter"
      :config (setup! :treesitter)
   })
   (use! "p00f/nvim-ts-rainbow" {
      :dependencies ["nvim-treesitter"]
   })
   (use! "JoosepAlviste/nvim-ts-context-commentstring" {
      :dependencies ["nvim-treesitter"]
   })

   (use! "nvim-treesitter/nvim-treesitter-context" {
   })
   (use! "nvim-treesitter/nvim-treesitter-textobjects" {
   })
   (use! "ziontee113/syntax-tree-surfer")
   (use! "kaarmu/typst.vim" {
      :ft "typ"
   })

   (use! "monkoose/matchparen.nvim" {
      :config (setup! :matchparen)
   })
   (use! "kylechui/nvim-surround")
   (use! "rrethy/vim-hexokinase" {
      :build "make hexokinase"
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
   (use! "wesleimp/stylua.nvim" {
      :ft ["lua"]
   })
   ;; (use! "NMAC427/guess-indent.nvim" {
   ;;    :config (setup! :guess-indent)
   ;; })
   (use! "Darazaki/indent-o-matic" {

      :event "User AlphaLeave"
      :config (setup! :indent-o-matic)
   })


   ;; git
   (use! "lewis6991/gitsigns.nvim" {
      :config (setup! :gitsigns)
   })

   (use! "sindrets/diffview.nvim" {
   })

   ;; Nav
   (use! "phaazon/hop.nvim" {
      :config (setup! :hop)
   })
   (use! "nacro90/numb.nvim" {
      :config (setup! :numb)
   })
   (use! "karb94/neoscroll.nvim" {
      :config (setup! :neoscroll)
   })
   ;; (use! "wfxr/minimap.vim" {
   ;;    :run "cargo install code-minimap"
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
      :dependencies ["nvim-treesitter"]
      :config (setup! :neorg)
   })
   (use! "nvim-orgmode/orgmode" {
      :ft ["org"]
      :dependencies ["nvim-treesitter"]
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
      :lazy false
      :config (setup! :transparent)
   })

   ;; (use! "Pocco81/auto-save.nvim" {
   ;;    :config (setup! :autosave)
   ;; })
   (use! "b0o/schemastore.nvim")
   (use! "ellisonleao/glow.nvim" {
      :cmd ["Glow"]
      :config (lite-setup! :glow {
         :style "light"
      })
   })
   (use! "CRAG666/code_runner.nvim" {
      :event "User AlphaLeave"
      :dependencies "nvim-lua/plenary.nvim"
      :config (setup! :code_runner)
   })

   (opts {
      :defaults {
         ; :lazy true
      }
      :ui {
         :border "single"
         :icons {
            :cmd "⌘"
            :config "🛠"
            :event "📅"
            :ft "📂"
            :init "⚙"
            :keys "🗝"
            :plugin "🔌"
            :runtime "💻"
            :source "📄"
            :start "🚀"
            :task "📌"
            :lazy ""
         }
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
