;; Color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'solarized-dark t)
(load-theme 'zenburn t)

;; UTF-8
(prefer-coding-system 'utf-8)

;; Default font
(custom-set-faces
 '(default ((t (:family "Consolas for Powerline FixedD" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))

;; Default 80 columns wide
(setq-default fill-column 80)

;; =============================================================================
;; Package Management
;; =============================================================================

;; Setup the Marmalade package repository.
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Ensure my packages are installed.
;; Solution copied from: https://github.com/technomancy/emacs-starter-kit
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(
  evil)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; =============================================================================
;; Package Configuration
;; =============================================================================

;; Load Evil
(require 'evil)
(evil-mode 1)
