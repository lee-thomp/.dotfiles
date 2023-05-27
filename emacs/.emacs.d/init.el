(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-operandi-tinted))
 '(custom-safe-themes
   '("76f5d6ce2d1792142231cab87260e526db3f8a542c9aaf36fa8e98ea3a339235" "31c0444ad6f28f6d0d6594add71a8960bf5a29f14f0c1e9e5a080b41f6149277" "cd80f569cdd67056b414923f67e3ea4c952876b7f0398b6dd3bb76cad0d6a2d5" "5fdc0f5fea841aff2ef6a75e3af0ce4b84389f42e57a93edc3320ac15337dc10" "71ac1434a07579da9b1ec1dd1a2b9cfa3182523d750678b68db6c25749fb6494" "986cdc701d133f7c6b596f06ab5c847bebdd53eb6bc5992e90446d2ddff2ad9e" default))
 '(package-selected-packages
   '(nasm-mode disaster poke poke-mode lsp-mode iedit haskell-mode merlin tuareg magit evil-cleverparens rust-mode cider web-mode clojure-mode undo-tree yasnippet sly company geiser-racket modus-themes ligature parinfer-rust-mode linum-relative evil use-package))
 '(tool-bar-mode nil))
'(modus-themes ligature parinfer-rust-mode linum-relative evil use-package)
 '(tool-bar-mode nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 113 :width normal))))
 '(fixed-pitch ((t (:family "Fira Code Regular"))))
 '(variable-pitch ((t (:family "Sans Serif")))))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

;; ========================================
;; Manual Config
 
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(fixed-pitch ((t (:family "Fira Code Regular")))))

;; (Hopefully) set tab width to 4 everywhere
(setq tab-width 4)

;; Switch off big toolbar
(tool-bar-mode 0)

;; Easier Ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; All backups in one dir
(setq backup-directory-alist '(("." . "~/.emacs.tmp/backup")))

;; Word-delimited wrap
(global-visual-line-mode)

;; ========================================
;; Packages

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
  :init
  (setq evil-want-C-i-jump nil)
  :config
  (define-key evil-normal-state-map (kbd "C-r") 'undo-redo)
  (define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)
  (evil-mode))

(add-hook 'ibuffer-mode-hook 'evil-normal-state)
  

;; Line nums relative and absolute
(use-package linum-relative
  :init
  (setq linum-relative-current-symbol "")
  :config
  (linum-relative-global-mode t))
  

;; Parinfer
(use-package parinfer-rust-mode
  :hook '(scheme-mode
	  clojure-mode
	  lisp-mode))


;; Cleverparens
(use-package evil-cleverparens
  :hook '(scheme-mode
	  clojure-mode
	  lisp-mode))
 

;; Company
(use-package company
  :config
  (company-tng-configure-default)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (global-company-mode))


;; Yasnippet
(use-package yasnippet
  :hook ((c-mode
	  emacs-lisp-mode
		  ) . yas-minor-mode-on)
  :init
  (setq yas-snippet-dir "~/.emacs.d/snippets"))


;; Undo Tree
(use-package undo-tree
  :init
  (global-undo-tree-mode)
  :config
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.tmp/undo-tree"))))
  
;; Org Babel Racket
(add-to-list 'load-path "/home/lee/.emacs.d/manual/ob-racket/")
(use-package ob-racket
  :after org
  :config
  (append '((racket . t) (scribble . t)) org-babel-load-languages))

;; Web Mode
(use-package web
  :hook
  html-mode
  )

;; Disaster Mode
(use-package disaster
  :config
  (setq disaster-assembly-mode 'nasm-mode)
  (setq disaster-objdump "objdump -d -M intel -Sl --no-show-raw-insn"))
(add-hook 'c-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c d") 'disaster)))

;; Ligatures
(use-package ligature
  :config
  (ligature-set-ligatures 't
        '(;; == === ==== => ==> =>= =<= =| =/= =~ =:= =!= =>>=<<=|=/=
          ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "="))))
	  ;; -- --- ---- -> -< -| -|- -~ -+-
          ("-" (rx (+ (or "-" ">" "<" "|" "~" "+"))))
	  ;; /* // /// /> /= /\
	  ("/" (rx (or "*" ">" "=" "\\" (+ "/"))))
	  ;; ;; ;;;
	  (";" (rx (+ ";")))
	  ;; << <<< <= <<= <== <=> <=< </ </> <> <~> <$ <$> <+ <+> <* <*> <- <!--
	  ("<" (rx (+ (or "<" "=" ">" "/" "~" "$" "+" "*" "!" "-"))))
	  ;; >> >>> >= >>= >== >=>
	  (">" (rx (+ (or ">" "="))))
	  ;; !! !!! != !== !~ !. !!. !: 
	  ("!" (rx (or "~" (+ (or "!" "=" "\." ":")))))
	  ;; ?? ??? ?: ?= ?.
	  ("?" (rx (or ":" "=" "\." (+ "?"))))
	  ;; *** */ *>
	  ("*" (rx (or (+ "*") "/" ">")))
	  ;; %% %%%
	  ("%" (rx (+ "%")))
	  ;; \\ \\\ \n \/
	  ("\\" (rx (or "/" "n" (+ "\\"))))
	  ;; ++ +++ ++++ +>
	  ("+" (rx (or ">" (+ "+"))))
	  ;; 0xFF 0x1234
	  ("0" (rx (and "x" (+ (in "A-F" "a-f" "0-9")))))
	  ;; ~~ ~- ~> ~@
	  ("~" (rx (+ (or "~" "-" ">" "@"))))
	  ))
  
  (global-ligature-mode))


;; C
(add-hook 'c-mode-hook '(lambda () (setq c-default-style "linux"
					 c-basic-offset 4)))

;; Loose hooks
(add-hook 'org-mode-hook 'visual-line-mode)

