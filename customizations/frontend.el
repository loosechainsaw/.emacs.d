(require 'web-mode)
(require 'company-css)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-block-face t)

;;(set-face-attribute 'web-mode-html-tag-face nil :foreground "#1D4183")
(set-face-attribute 'web-mode-html-tag-face nil :foreground "#FFE5B4")
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "#3C65B1")
(set-face-attribute 'web-mode-html-attr-name-face nil :foreground "Orange")
;;(setq web-mode-ac-sources-alist
;;      '(("css" . (ac-source-css-property))
;;        ("html" . (ac-source-words-in-buffer ac-source-abbrev)))
;;      )

(add-hook 'css-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends) '(company-css))))
