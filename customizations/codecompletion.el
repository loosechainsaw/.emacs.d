(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-\\") 'company-complete)

(setq company-global-modes '(not term-mode))

(setq company-minimum-prefix-length 2
      company-selection-wrap-around t
      company-show-numbers t
      company-tooltip-align-annotations t
      company-require-match nil)


;;(require 'auto-complete-config)

;;(defun css-setup-ac ()
;;  (setq ac-sources '(ac-source-dictionary ac-source-words-in-same-mode-buffers))
;;  (ac-css-mode-setup)
;;  (auto-complete-mode 1))

;;(add-hook 'css-mode-hook #'css-setup-ac)
