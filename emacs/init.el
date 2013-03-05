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

;; Show 81 columns to make room for the Fill Column Indicator
(add-to-list 'default-frame-alist '(width . 81))

;; Fill Column Indicator
;; Use fci-mode for all files
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fci-rule-color "#6f6f6f")

;; Use aspell for spell check
(add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
(custom-set-variables
 '(ispell-dictionary "american")
 '(ispell-program-name "aspell.exe"))

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
