(local treesitter_config (require "nvim-treesitter.configs"))

(treesitter_config.setup {
   :ensure_installed [
      "bash"
      "c"
      "cpp"
      "javascript"
      "json"
      "lua"
      "python"
      "typescript"
      "tsx"
      "css"
      "rust"
      "java"
      "yaml"
      "fennel"
      "dot"
      "dockerfile"
      "fish"
      "go"
      "html"
      "json5"
      "kotlin"
      "latex"
      "llvm"
      "make"
      "norg"
      "ocaml"
      "regex"
      "scala"
      "scheme"
      "toml"
      "org"
      "norg"
   ]
   :ignore_install []
   :highlight {
      :enable true
      :additional_vim_regex_highlighting ["org"]
   }
   :indent {
      :enable true
   }
   :matchup {
      :enable true
   }
   :autopairs {
      :enable true
   }
   :context_commentstring {
      :enable true
      :enable_autocmd false
      :config {
        ;; Languages that have a single comment style
        :typescript "// %s"
        :css "/* %s */"
        :scss "/* %s */"
        :html "<!-- %s -->"
        :svelte "<!-- %s -->"
        :vue "<!-- %s -->"
        :json ""
      }
    }
    :rainbow {
      :enable true
      ;; :colors [
      ;;    "#f38ba8"
      ;;    "#a6e3a1"
      ;;    "#f9e2af"
      ;;    "#94e2d5"
      ;;    "#89dceb"
      ;;    "#74c7ec"
      ;;    "#87b0f9"
      ;; ]
   }
})
