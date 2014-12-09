;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")

;; Uncomment this to increase font size
;; (set-face-attribute 'default nil :height 140)
(load-theme 'dakrone t)

;; Smart mode line goodness
(require 'smart-mode-line)
(require 'smart-mode-line-powerline-theme)
(setq sml/no-confim-theme-load)
(sml/setup)
(sml/apply-theme 'dark)
