;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Define packages
(defvar package-listing
  '(

    ;; git integration
    git-gutter-fringe
    magit
    
    ;; Usability
    smex
    ido-ubiquitous
    ido-vertical-mode
    imenu
    
    ;; Theming etc
    rainbow-mode
    rainbow-delimiters
    noctilux-theme
    
    ;; Autocomplete
    auto-complete
    
    ;; Clojure related packages
    clojure-mode
    cider
    clojure-mode-extra-font-locking
    ac-cider

    ;; Editing

 ))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'package-listing 'exec-path-from-shell))

(dolist (p package-listing)
  (when (not (package-installed-p p))
    (package-install p)))

;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; ido, smex, imenu configuration
(load "usability.el")

;; Themeing
(load "appearance.el")