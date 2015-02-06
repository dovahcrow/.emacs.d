(global-set-key (kbd "<C-S-up>")    'tabbar-backward-group)
(global-set-key (kbd "<C-S-down>")  'tabbar-forward-group)
(global-set-key (kbd "<C-S-left>")  'tabbar-backward-tab)
(global-set-key (kbd "<C-S-right>") 'tabbar-forward-tab)

;; no buttons
(setq
 tabbar-buffer-home-button (quote (("") ""))
 tabbar-scroll-left-button (quote (("") ""))
 tabbar-scroll-right-button (quote (("") ""))
 )

;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
		    :family "Comic Sans MS" ;"Vera Sans YuanTi Mono"
		    :background "#000000"
		    :foreground "#FFFFFF"
		    :height 1.0
		    )

(setq tabbar-separator-value "|")
(setq tabbar-separator (list 0.5))
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
		    :inherit 'tabbar-default
		    :foreground "orange" ;"DarkGreen"
		    :background "#000000" ;"LightGoldenrod"
		    :box '(:line-width 2
				       :color "DarkGoldenrod"
				       :style 'pressed-button)
		    :weight 'bold
		    )

;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
		    :inherit 'tabbar-default
		    :box '(:line-width 2 :color "dark gray" :style 'released-button))



(defun tabbar-buffer-groups ()
  "tabbar group"
  (list
   (cond
    ((memq major-mode '(shell-mode sh-mode))
     "shell"
     )
    ((memq major-mode '(c-mode c++-mode))
     "cc"
     )
    ((memq major-mode '(dired-mode ibuffer-mode))
     "files"
     )
    ((eq major-mode 'python-mode)
     "python"
     )
    ((eq major-mode 'ruby-mode)
     "ruby"
     )
    ((memq major-mode
	   '(php-mode nxml-mode nxhtml-mode))
     "WebDev"
     )
    ((eq major-mode 'emacs-lisp-mode)
     "Emacs-lisp"
     )
    ((memq major-mode
	   '(tex-mode latex-mode text-mode snippet-mode org-mode moinmoin-mode markdown-mode))
     "Text"
     )
    ((string-equal "*" (substring (buffer-name) 0 1))
     "emacs"
     )
    (t
     "other"
     )
    )))

