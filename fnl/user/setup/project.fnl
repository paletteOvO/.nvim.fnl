(import-macros { : require-as! } :user.macros.require)

(require-as! project :project_nvim)

(project.setup {
   :detection_methods [ "pattern" ]
  :patterns [ "justfile" ".git" "Makefile" "package" ]
})

(import-macros { : let-require! } :user.macros.require)

(let-require! [telescope "telescope"]
  (telescope.load_extension "projects")
)

