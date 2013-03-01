;; Setup the Marmalade package repository.
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Load Evil
(require 'evil)
(evil-mode 1)

;; Color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'solarized-dark t)
(load-theme 'zenburn t)


;; Default font
(custom-set-faces
 '(default ((t (:family "Consolas for Powerline FixedD" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))

;; UTF-8
(prefer-coding-system 'utf-8)