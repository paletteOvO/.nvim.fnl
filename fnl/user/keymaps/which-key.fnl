(local config {
   :active true
   :mappings {
      ";" [ "<cmd>Alpha<cr>" "Dashboard" ]
      "/" [ "<cmd>lua require('Comment.api').toggle.linewise.current(nil)<cr>" "Comment" ]
      "r" [ "<cmd>RunFile<CR>" "Run Current File" ]
      :e [ "<cmd>NeoTreeShowToggle<cr>" "Explorer" ]
      :h [ "<cmd>nohlsearch<cr>" "No Highlight" ]
      :f [ "<cmd>Telescope find_files<cr>" "Find File" ]
      :S [ "<cmd>w!<cr>" "Save" ]
      :w {
         :name "Window"
         "<Left>" [ (lambda [] (vim.cmd "wincmd h")) "Left"]
         "<Right>" [ (lambda [] (vim.cmd "wincmd l")) "Right"]
         "<Up>" [ (lambda [] (vim.cmd "wincmd k")) "Up"]
         "<Down>" [ (lambda [] (vim.cmd "wincmd j")) "Down"]
         "h" [ (lambda [] (vim.cmd "wincmd h")) "Left"]
         "l" [ (lambda [] (vim.cmd "wincmd l")) "Right"]
         "k" [ (lambda [] (vim.cmd "wincmd k")) "Up"]
         "j" [ (lambda [] (vim.cmd "wincmd j")) "Down"]
      }
      :a [
         "<cmd>lua vim.lsp.buf.code_action()<cr>"
         "Code Action"
      ]
      :l {
         :name "LSP"
         :q [ "<cmd>lua vim.diagnostic.setloclist()<cr>" "Quickfix" ]
         :i [ "<cmd>LspInfo<cr>" "Info" ]
         :f [ "<cmd>lua vim.lsp.buf.formatting()<cr>" "Format" ]
         :w [ "<cmd>Telescope diagnostics<cr>" "Diagnostics" ]
         :l [ "<cmd>lua vim.lsp.codelens.run()<cr>" "CodeLens Action" ]
         :S [ "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" "Workspace Symbols" ]
         :j [ "<cmd>lua vim.diagnostic.goto_next()<cr>" "Next Diagnostic" ]
         :k [ "<cmd>lua vim.diagnostic.goto_prev()<cr>" "Prev Diagnostic" ]
         :p {
            :name "Peek"
            :d [ "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>" "Definition" ]
            :i [ "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>" "Implementation" ]
            :t [ "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>" "Type Definition" ]
         }
         :a [
            "<cmd>lua vim.lsp.buf.code_action()<cr>"
            "Code Action"
         ]
         :I [ "<cmd>LspInstallInfo<cr>" "Installer Info" ]
         :d [ "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>" "Buffer Diagnostics" ]
         :e [ "<cmd>Telescope quickfix<cr>" "Telescope Quickfix" ]
         :r [ "<cmd>lua vim.lsp.buf.rename()<cr>" "Rename" ]
         :s [ "<cmd>Telescope lsp_document_symbols<cr>" "Document Symbols" ]
         :F [ "<cmd>lua vim.lsp.buf.references()<cr>" "Reference"]
      }
      :G {
         :name "Git"
         :R [ "<cmd>lua require 'gitsigns'.reset_buffer()<cr>" "Reset Buffer" ]
         :C [ "<cmd>Telescope git_bcommits<cr>" "Checkout commit(for current file)" ]
         :l [ "<cmd>lua require 'gitsigns'.blame_line()<cr>" "Blame" ]
         :c [ "<cmd>Telescope git_commits<cr>" "Checkout commit" ]
         :j [ "<cmd>lua require 'gitsigns'.next_hunk()<cr>" "Next Hunk" ]
         :k [ "<cmd>lua require 'gitsigns'.prev_hunk()<cr>" "Prev Hunk" ]
         :p [ "<cmd>lua require 'gitsigns'.preview_hunk()<cr>" "Preview Hunk" ]
         :b [ "<cmd>Telescope git_branches<cr>" "Checkout branch" ]
         :o [ "<cmd>Telescope git_status<cr>" "Open changed file" ]
         :d [ "<cmd>Gitsigns diffthis HEAD<cr>" "Git Diff" ]
         :u [ "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>" "Undo Stage Hunk" ]
         :r [ "<cmd>lua require 'gitsigns'.reset_hunk()<cr>" "Reset Hunk" ]
         :s [ "<cmd>lua require 'gitsigns'.stage_hunk()<cr>" "Stage Hunk" ]
      }
      :P {
         :name "Packer"
         :i [ "<cmd>PackerInstall<cr>" "Install" ]
         :S [ "<cmd>PackerStatus<cr>" "Status" ]
         :s [ "<cmd>PackerSync<cr>" "Sync" ]
         :u [ "<cmd>PackerUpdate<cr>" "Update" ]
         :c [ "<cmd>PackerCompile<cr>" "Compile" ]
      }
      :q [ "<cmd>wqa!<cr>" "Write and Quit All" ]
      :Q [ "<cmd>qa!<cr>" "Quit All"]
      :s {
         :name "Search"
         :h [ "<cmd>Telescope help_tags<cr>" "Find Help" ]
         :f [ "<cmd>Telescope find_files<cr>" "Find File" ]
         :M [ "<cmd>Telescope man_pages<cr>" "Man Pages" ]
         :C [ "<cmd>Telescope commands<cr>" "Commands" ]
         :k [ "<cmd>Telescope keymaps<cr>" "Keymaps" ]
         :p [ "<cmd>Telescope projects<cr>" "Find Project" ]
         :r [ "<cmd>Telescope oldfiles<cr>" "Open Recent File" ]
         :R [ "<cmd>Telescope registers<cr>" "Registers" ]
         :t [ "<cmd>Telescope live_grep<cr>" "Text" ]
         :H [ "<cmd>Telescope highlights<cr>" "Find highlight groups" ]
         :b [ "<cmd>Telescope git_branches<cr>" "Checkout branch" ]
         :c [ "<cmd>Telescope colorscheme<cr>" "Colorscheme" ]
      }
      :T {
         :name "Treesitter"
         :i [ ":TSConfigInfo<cr>" "Info" ]
      }
      :C [ "<cmd>edit ~/.config/nvim/init.lua<cr>" "Edit config file" ]
      :b {
         :name "Buffers"
         :h [ "<cmd>BufferLineCloseLeft<cr>" "Close all to the left" ]
         :f [ "<cmd>Telescope buffers<cr>" "Find" ]
         :l [ "<cmd>BufferLineCloseRight<cr>" "Close all to the right" ]
         :j [ "<cmd>BufferLinePick<cr>" "Jump" ]
         :D [ "<cmd>BufferLineSortByDirectory<cr>" "Sort by directory" ]
         :e [ "<cmd>BufferLinePickClose<cr>" "Pick which buffer to close" ]
         :b [ "<cmd>BufferLineCyclePrev<cr>" "Previous" ]
         :L [ "<cmd>BufferLineSortByExtension<cr>" "Sort by language" ]
      }
      :c [ "<cmd>BufferKill<CR>" "Close Buffer" ]
   }
   :vmappings {
      "/" [ "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" "Comment" ]
   }
   :opts {
      :mode "n"
      :nowait true
      :noremap true
      :prefix "<leader>"
      :silent true
   }
   :vopts {
      :mode "v"
      :nowait true
      :noremap true
      :prefix "<leader>"
      :silent true
   }
   :setup {
      :ignore_missing false
      :window {
         :border "single"
         :position "bottom"
         :margin [ 1 0 1 0 ]
         :winblend 0
         :padding [ 2 2 2 2 ]
      }
      :popup_mappings {
         :scroll_up "<c-u>"
         :scroll_down "<c-d>"
      }
      :layout {
         :width {
            :max 50
            :min 20
         }
         :height {
            :max 25
            :min 4
         }
         :align "left"
         :spacing 3
      }
      :hidden [
         "<silent>"
         "<cmd>"
         "<Cmd>"
         "<CR>"
         "call"
         "lua"
         "^:"
         "^ "
      ]
      :triggers_blacklist {
         :v [
            "j"
            "k"
         ]
         :i [
            "j"
            "k"
         ]
      }
      :show_help true
      :plugins {
         :presets {
            :g true
            :z true
            :operators false
            :nav true
            :motions false
            :windows false
            :text_objects false
         }
         :marks true
         :spelling {
            :suggestions 20
            :enabled true
         }
         :registers true
      }
      :icons {
         :separator "➜"
         :breadcrumb "»"
         :group "+"
      }
      :triggers "auto"
   }
})

(import-macros { : let-require! } :user.macros.require)

(let-require! [which_key "which-key"]
   (_G.logger:info "which_key.setup")
   (which_key.setup config.setup)
   (which_key.register config.mappings config.opts)
   (which_key.register config.vmappings config.vopts)
)
