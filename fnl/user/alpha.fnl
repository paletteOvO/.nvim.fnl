(local alpha (require "alpha"))

(local dashboard (require "alpha.themes.dashboard"))
(set dashboard.section.header.val (require :user.alpha_header))
(set dashboard.section.buttons.val [
   (dashboard.button "e" (.. " " " New file") ":ene <BAR> startinsert <CR>")
   (dashboard.button "f" (.. " " " Find file") ":Telescope find_files <CR>")
   (dashboard.button "p" (.. " " " Find project") ":Telescope projects <CR>")
   (dashboard.button "r" (.. " " " Recent file") ":Telescope oldfiles <CR>")
   (dashboard.button "c" (.. " " " Config") ":e ~/.config/nvim/init.lua <CR>")
   (dashboard.button "l" (.. "📦" " Plugin") ":Lazy <CR>")
   (dashboard.button "q" (.. " " " Quit") ":qa<CR>")
])
(set dashboard.section.footer.val (require :user.alpha_footer))
(set dashboard.section.footer.opts.hl "Type")
(set dashboard.section.header.opts.hl "Include")
(set dashboard.section.buttons.opts.hl "Keyword")
(set dashboard.opts.opts.noautocmd true)
(alpha.setup dashboard.opts)
