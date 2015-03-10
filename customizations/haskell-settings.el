(require 'haskell)

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(custom-set-variables '(haskell-tags-on-save t))

;; Setup haskell-mode hooks
(eval-after-load "haskell-mode"
  '(custom-set-variables
    '(haskell-mode-hook
      '(turn-on-haskell-indentation
        turn-on-haskell-doc
        ;; structured-haskell-mode
        ))))

;; Use Unicode arrows in place of ugly ASCII arrows
(defun setup-haskell-arrows (mode mode-map)
  (font-lock-replace-symbol mode "\\(->\\)" "→")
  (font-lock-replace-symbol mode "\\(<-\\)" "←")
  (font-lock-replace-symbol mode "\\(=>\\)" "⇒")

  (define-key mode-map (kbd "→") (lambda () (interactive) (insert "->")))
  (define-key mode-map (kbd "←") (lambda () (interactive) (insert "<-")))
  (define-key mode-map (kbd "⇒") (lambda () (interactive) (insert "=>"))))
(eval-after-load "haskell-mode"
  '(setup-haskell-arrows 'haskell-mode haskell-mode-map))

;; Setup haskell-interactive-mode
;;(eval-after-load "haskell-mode"
;;  '(progn
;;     (define-key haskell-mode-map (kbd "C-x C-d") nil)
;;     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
;;     (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
;;     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;;     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;;     (define-key haskell-mode-map (kbd "C-c C-s") (lambda () (interactive) (haskell-process-do-type t)))
;;     (define-key haskell-mode-map (kbd "C-c M-.") nil)
;;    (define-key haskell-mode-map (kbd "C-c C-d") nil)))

(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))

(eval-after-load "haskell-mode"
  '(progn
      (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
      (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
      (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
      (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
      (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
      (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
      (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))

(eval-after-load "haskell-cabal"
  '(progn
     (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

;; Put ghc-show-info in a popup
(defun ghc-show-info-popup ()
  (interactive)
  (popup-tip (ghc-get-info (ghc-things-at-point))
             :around t :scroll-bar t))
(define-key haskell-mode-map (kbd "C-c TAB") 'ghc-show-info-popup)
(define-key haskell-mode-map (kbd "C-c C-i") 'ghc-show-info-popup)
(define-key haskell-mode-map (kbd "C-c C-S-i") 'ghc-show-info)

;; Use standard keybinding for inferior-haskell-find-definition
(define-key haskell-mode-map (kbd "M-.")
  (lambda () (interactive)
    (inferior-haskell-find-definition (haskell-ident-at-point))))

;; Flycheck addons
;;(eval-after-load 'flycheck
;;    '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
