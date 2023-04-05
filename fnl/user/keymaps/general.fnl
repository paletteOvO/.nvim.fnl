(import-macros { : let-require! : require-as! } :user.macros.require)
;; Shorten function name
;; Silent keymap option
(macro keymap [mode key map ?opts]
    (local opts (if (= ?opts nil) { :silent true } ?opts))
    `(vim.keymap.set ,mode ,key ,map ,opts)
)

(macro nya_jump []
   `(lambda []
      (local hop# (require :hop))
      (hop#.hint_patterns {} "[a-zA-Z0-9\"']\\+")
   )
)

;; Remap space as leader key
(keymap "" "<Space>" "<Nop>")
(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")

;; Modes
;;   normal_mode = "n",
;;   insert_mode = "i",
;;   visual_mode = "v",
;;   visual_block_mode = "x",
;;   term_mode = "t",
;;   command_mode = "c",

;; C -> File/Cursor
;; A -> Content
;; S -> Window/View

;; disable default keymap
(keymap "" "q" "<Nop>")
(keymap "n" "<C-r>" "<Nop>")
(keymap "v" "<C-r>" "<Nop>")
(keymap "" "<C-z>" "<Nop>")
(keymap "" "<C-a>" "<Nop>")
(keymap "" "<C-o>" "<Nop>")
(keymap "" "<C-f>" "<cmd>Telescope live_grep<cr>")

;; basic common shortcut
(keymap :n "<C-z>" "<cmd>silent undo<cr>")
(keymap :n "<C-y>" "<cmd>silent redo<cr>")
(keymap :n "<C-s>" "<cmd>write!<cr>")
(keymap :n "<C-c>" "<cmd>.yank<cr>")
(keymap :n "<C-v>" "p")
(keymap :n "<C-k>" "\"_dd")
(keymap :n "<C-x>" "<cmd>d<cr>")

(keymap :n "<C-w>" "<Nop>")
(keymap :n "<S-w>" "<C-w>" { :noremap true })
;; Cursor Navigate
(keymap :n "<C-j>" (nya_jump))
(keymap :n "<C-l>" "<cmd>HopLine<CR>")
(keymap :n "<C-q>" "^")
(keymap :n "<C-a>" "^")
(keymap :n "<C-e>" "$")
(keymap :n "<C-Up>" (lambda []
   (local neoscroll (require "neoscroll"))
   (neoscroll.scroll -10 true 240 nil)
))
(keymap :n "<C-Down>" (lambda []
   (local neoscroll (require "neoscroll"))
   (neoscroll.scroll 10 true 240 nil)
))
(keymap :n "K" (lambda [] ((. (require "hover") :hover))))

(keymap :i "<C-o>" "<esc>o")
(keymap :i "<C-S-o>" "<esc>O")

;; Move Line
(keymap :n "<A-Up>" "<cmd>m .-2<CR>")
(keymap :n "<A-Down>" "<cmd>m .+1<CR>")

;; Indent
(keymap :n "<A-Left>" "V<")
(keymap :n "<A-Right>" "V>")

;; Close Buffer
; TODO: fix it for neotree
; (keymap :n "<S-q>" "<cmd>Bdelete!<CR>")

(keymap :n "<S-n>" (lambda []
   (let-require! [illuminate :illuminate]
      (illuminate.next_reference { :wrap true })
   )
))

(keymap :n "<S-p>" (lambda []
   (let-require! [illuminate :illuminate]
      (illuminate.next_reference { :reverse true :wrap true })
   )
))

(keymap :n "<A-f>" (lambda [] (vim.cmd "Trouble")))

;; -- Insert --
(keymap :i "<C-z>" "<cmd>silent undo<CR>")
(keymap :i "<C-y>" "<cmd>silent redo<CR>")
(keymap :i "<C-s>" "<cmd>write!<CR>")
(keymap :i "<C-c>" "<cmd>.yank<cr>")
(keymap :i "<C-v>" "<esc>\"_dPa")

(keymap :i "<C-j>" (nya_jump))
(keymap :i "<C-l>" "<cmd>HopLine<CR>")

(keymap :i "<C-q>" "<ESC>^i")
(keymap :i "<C-a>" "<ESC>^i")
(keymap :i "<C-e>" "<ESC>$a")
;; (keymap :i "<Enter>" "<ESC>o")
;; (keymap :i "<C-Enter>" "<Enter>")

;; Move line up/down
(keymap :i "<A-Up>"   "<cmd>m .-2<CR>")
(keymap :i "<A-Down>" "<cmd>m .+1<CR>")

(keymap :i "<A-Left>" "<ESC>v<<ESC>a")
(keymap :i "<A-Right>" "<ESC>v><ESC>a")

;; quick fix
(keymap :i "<A-f>" (lambda [] ((. (require :nvim-lightbulb) :update_lightbulb))))
(keymap :i "<A-a>" (lambda [] (vim.cmd "CodeActionMenu")))

(keymap :i "<C-Up>" (lambda []
   (local neoscroll (require "neoscroll"))
   (neoscroll.scroll -0.2 true 240 nil)
))
(keymap :i "<C-Down>" (lambda []
   (local neoscroll (require "neoscroll"))
   (neoscroll.scroll 0.2 true 240 nil)
))
;; -- Visual --
;; Better paste
(keymap :v "p" "\"_dP")
(keymap :v "<C-c>" "y")
(keymap :v "<C-v>" "\"_dP")
(keymap :v "<C-x>" "d")

(keymap :v "<A-Up>"   ":m -2<CR>gv")
(keymap :v "<A-Down>" ":m +1<CR>gv")

(keymap :v "<A-Left>" "<gv")
(keymap :v "<A-Right>" ">gv")
