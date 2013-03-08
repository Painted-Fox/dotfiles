;; Color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'solarized-dark t)
(load-theme 'zenburn t)

;; UTF-8
(prefer-coding-system 'utf-8-with-signature-unix)

;; Default font
(custom-set-faces
 '(default ((t (:family "Consolas for Powerline FixedD" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))

;; Default 80 columns wide
(setq-default fill-column 80)

;; Show 82 columns to make room for the Fill Column Indicator
(add-to-list 'default-frame-alist '(width . 82))

;; Default to 2 char wide tabs.
(setq default-tab-width 2)

;; whitespace-mode
;; make whitespace-mode use just basic coloring
(setq whitespace-style (
  quote (spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-display-mappings
 ;; all numbers are Unicode codepoint in decimal. ⁖ (insert-char 182 1)
 '(
 (space-mark 32 [183] [46]) ; 32 Space 「 」, 183 Middle Dot, 46 Full Stop
 (newline-mark 10 [8629 10]) ; 10 Line Feed, 8629 Downwards Arrow w/ Corner
 (tab-mark 9 [8594 9] [92 9]) ; 9 TAB, 8594 Rightwards Arrow, 92 Backslash \
 ))

;; Delete trailing whitespace before we save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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
  evil
  fill-column-indicator)
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

;; Fill Column Indicator
;; Use fci-mode for all files
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fci-rule-color "#6f6f6f")

