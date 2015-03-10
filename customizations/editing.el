;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; yay rainbows!
;;(require 'rainbow-delimiters)
;;(global-rainbow-delimiters-mode t)

(require 'cl-lib)
(require 'color)
;;(cl-loop
;; for index from 1 to rainbow-delimiters-max-face-count
;; do
;; (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
;;   (cl-callf color-saturate-name (face-foreground face) 30)))

;;(set-face-attribute 'rainbow-delimiters-unmatched-face nil
;;                    :foreground 'unspecified
;;                    :inherit 'error
;;                    :strike-through t)
;;
;; Expand Region
(global-set-key (kbd "C-j") 'er/expand-region)
