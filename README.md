# wooya's emacs config
====================================

* package list

    (setq my-packages '(ace-jump-mode auto-complete cl-lib company-mode dash el-get ensime fuzzy git-modes go-autocomplete go-mode icomplete+ json-mode json-reformat json-snatcher magit monokai-theme neotree package popup rainbow-mode rust-mode rusti s sbt-mode scala-mode2 session switch-window tabbar tramp undo-tree yasnippet))

* add this to `~/.emacs`

    (add-to-list 'load-path "~/.emacs.d/init")
    (require 'init-init)
