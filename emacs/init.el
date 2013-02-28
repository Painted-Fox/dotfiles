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
(load-theme 'solarized-dark t)
