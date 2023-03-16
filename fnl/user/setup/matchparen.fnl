(import-macros { : require-as! } :user.macros.require)

(require-as! matchparen :matchparen)

(matchparen.setup)

(vim.cmd "hi MatchParen gui=bold,underline")
