(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ligature parinfer-rust-mode linum-relative evil use-package)))
(custom-set-faces)
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(fixed-pitch ((t ( :family "Fira Code Regular")))))

;; Switch off big toolbar
(tool-bar-mode 0)

;; Load package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


;; Ido mode
(use-package ido
  :init
  (setq ido-everywhere t)
  :config
  (ido-mode t))

  

;; Evil mode
(use-package evil
  :config
  (evil-mode))
  

;; Line nums relative and absolute
(use-package linum-relative
  :init
  (setq linum-relative-current-symbol "")
  :config
  (linum-relative-global-mode t))
  

;; Parinfer
(use-package parinfer-rust-mode
  :hook emacs-lisp-mode)
 
  
;; Ligatures
(use-package ligature
  :config
  (ligature-set-ligatures 't
        '(;; == === ==== => <= =| =/ =/= =~ =:= =!= =>>=<<=|=/=
          ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "=")))))))
  
 
