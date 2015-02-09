(provide 'init-init)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; el-get
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user-recipes")
(setq el-get-user-package-directory "~/.emacs.d/init")
(el-get 'sync)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; overall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; my mode line
;; use setq-default to set it for /all/ modes
;; http://emacs-fu.blogspot.com/2011/08/customizing-mode-line.html
(defun my-mode-line ()
  (setq-default
   mode-line-format
   (list
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize "%b " 'face 'font-lock-keyword-face
			'help-echo (format "%s" (buffer-file-name))
			))

    "[" ;; insert vs overwrite mode, input-method in a tooltip
    '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
			'face 'font-lock-preprocessor-face
			'help-echo (concat "Buffer is in "
 					   (if overwrite-mode "overwrite" "insert") " mode")))

    ;; was this buffer modified since the last save?
    '(:eval (when (buffer-modified-p)
	      (concat ","  (propertize "Mod"
				       'face 'font-lock-warning-face
				       'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
	      (concat ","  (propertize "RO"
				       'face 'font-lock-type-face
				       'help-echo "Buffer is read-only"))))
    "] "

    ;; ;; line and column
    ;; "(" ;; '%02' to set to 2 chars at least; prevents flickering
    ;; (propertize "%01l" 'face 'font-lock-type-face) ","
    ;; (propertize "%02c" 'face 'font-lock-type-face)
    ;; ") "

    ;; relative position, size of file
    "["
    (propertize "%p" 'face 'font-lock-constant-face) ;; % above top

    ;; (propertize "%I" 'face 'font-lock-constant-face) ;; size
    '(:eval (when (and (not (buffer-modified-p)) my-mode-line-buffer-line-count)
	      (propertize (concat "/" my-mode-line-buffer-line-count "L")
			  'face 'font-lock-type-face
			  )))

    "] "

    ;; the current major mode for the buffer.
    "["
    ;; mode-line-modes ;; too much infomation

    '(:eval (propertize "%m" 'face 'font-lock-string-face
			'help-echo buffer-file-coding-system))

    "] "

    '(:eval (when vc-mode
	      (concat "["
		      (propertize (string-strip (format "%s" vc-mode)) 'face 'font-lock-variable-name-face)
		      "] "
		      )))

    ;; '(:eval (format "Proj[%s] " (projectile-project-name)))

    ;; add the time, with the date and the emacs uptime in the tooltip
    '(:eval (propertize (format-time-string "%H:%M:%S")
			'face 'font-lock-type-face
			'help-echo
			(concat (format-time-string "%Y-%02m-%02d %02H:%02M:%02S %Y-%02m-%02d %3a; ")
				(emacs-uptime "Uptime:%hh"))))

    ;; show buffer file name
    '(:eval (when show-buffer-file-name
	      (format " [%s]" (buffer-file-name))))

    " "

    ;; date
    '(:eval (propertize (format-time-string "%Y-%02m-%02d %3a")
			'face 'font-lock-comment-face))


    " --"
    ;; i don't want to see minor-modes; but if you want, uncomment this:
    ;; minor-mode-alist  ;; list of minor modes
    "%-" ;; fill with '-'

    ;; mode-line-modes mode-line-misc-info mode-line-end-spaces
    ))
  ;; 这里不知道Emacs发生啥事，初始化完成后，mode-line-format就被设置回默认值。
  ;; (setq default-mode-line-format mode-line-format) ; 奇葩了，没有这行它就没法设置成功
  )
(my-mode-line)

;; molokai theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0eebf69ceadbbcdd747713f2f3f839fe0d4a45bd0d4d9f46145e40878fc9b098" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white")))))
(load-theme 'monokai)

;; close the menu bar
(menu-bar-mode -1)

;; replace yes/no with y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; 设置默认shell
(setq shell-file-name "/bin/bash")

;; 取消自动保存
(setq make-backup-file nil)
(setq auto-save-default nil)

;; (when (not package-archive-contents) (package-refresh-contents))

;;显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; minibar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; display line/col number on minibuffer bar
(setq column-number-mode t)
(setq line-number-mode t)

;; 显示时间
(display-time-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; title
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 显示当前位置
(setq frame-title-format "wooya@%b")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; global line number
(global-linum-mode)
(setq linum-format "%4d")

;; 增强minibuffer自动补全
(require 'icomplete)
(icomplete-mode 99)
(eval-after-load "icomplete" '(progn (require 'icomplete+)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set some keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; eshell to f4
(global-set-key [f4] 'eshell)

;; set region comment
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

;; move cursor
(global-set-key (kbd "M-C-<up>") 'windmove-up)
(global-set-key (kbd "M-C-<down>") 'windmove-down)
(global-set-key (kbd "M-C-<left>") 'windmove-left)
(global-set-key (kbd "M-C-<right>") 'windmove-right)

;; splist cursor
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-0") 'delete-window)

;; set backup directory
(setq backup-directory-alist (quote (("." . "~/.backups"))))

;; i hate C-x C-b
(global-unset-key (kbd "C-x C-b"))
;; as well as C-x C-k
(global-unset-key (kbd "C-x C-k"))

;; no case-insensitive in search
(setq case-fold-search nil)
(setq case-replace nil)

;; tabbar mode
(tabbar-mode t)

;; org ident-mode
(setq org-startup-indented t)
