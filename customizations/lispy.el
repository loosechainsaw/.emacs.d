(setq lisp-modes
      '(scheme-mode emacs-lisp-mode lisp-mode clojure-mode))

(defun add-lisp-hook (func)
  (add-hooks lisp-modes func))

;; Setup C-c v to eval whole buffer in all lisps
(define-key lisp-mode-shared-map (kbd "C-c v") 'eval-buffer)

;; Highlight sexp under cursor
(require 'highlight-parentheses)
(add-lisp-hook 'highlight-parentheses-mode)

(defun lambda-as-lambda (mode pattern)
  (font-lock-add-keywords
   mode `((,pattern
           (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                     "λ" 'decompose-region)))))))
;;; Emacs Lisp

(lambda-as-lambda 'emacs-lisp-mode "(\\(\\<lambda\\>\\)")

(defun remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'remove-elc-on-save)

(define-key emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)

;;; Clojure

(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.cljs?$" . clojure-mode))

(lambda-as-lambda 'clojure-mode "(\\(\\<fn\\>\\)")

;; nRepl
(require 'cider)
(eval-after-load "clojure-mode" '(require 'cider))
(setq nrepl-lein-command "lein")
(setq nrepl-server-command "echo \"lein repl :headless\" | $SHELL -l")
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; Run tests in nRepl
(defun nrepl-run-tests (ns)
  (interactive (list (nrepl-current-ns)))
  (save-buffer)
  (nrepl-load-current-buffer)
  (with-current-buffer "*nrepl*"
    (nrepl-send-string
     (format "(clojure.test/run-tests '%s)" ns)
     nrepl-buffer-ns (nrepl-handler (current-buffer)))))
(eval-after-load "clojure-mode"
  '(define-key clojure-mode-map (kbd "C-c C-,") 'nrepl-run-tests))

;;Kibit
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
             '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
(add-to-list 'compilation-error-regexp-alist 'kibit)

(defun kibit ()
  "Run kibit on the current project.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile "lein kibit"))

;; Cljsbuild
(require 'cljsbuild-mode)

;;; Various inferior lisps

;; Clojure REPL
(defun clojure-repl ()
  (interactive)
  (run-lisp "lein repl"))

;; ClojureScript REPL
(defun clojurescript-repl ()
  (interactive)
  (run-lisp "lein trampoline noderepl"))

;; ClojureScript REPL
(defun clojurescript-rhino-repl ()
  (interactive)
  (run-lisp "lein trampoline cljsbuild repl-rhino"))

;; Clojure-Py REPL
(defun clojurepy-repl ()
  (interactive)
  (run-lisp "/usr/local/bin/clojurepy"))

;; Switch a Clojure nrepl to ClojureScript

(defun nrepl-start-noderepl ()
  (interactive)
  (save-excursion
    (nrepl-switch-to-repl-buffer nil)
    (insert "(require 'cljs.repl.node) (cljs.repl.node/run-node-nrepl)")
    (nrepl-send-input)))

;; Short cut for cider
(global-set-key [f9] 'cider-jack-in)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")
  
;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer nil)
(setq cider-auto-select-error-buffer nil)

;; turn off prompt for save on repl load
(setq cider-prompt-save-file-on-load nil)
