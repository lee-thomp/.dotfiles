(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-operandi-deuteranopia))
 '(custom-safe-themes
   '("35335d6369e911dac9d3ec12501fd64bc4458376b64f0047169d33f9d2988201" "250007c5ae19bcbaa80e1bf8184720efb6262adafa9746868e6b9ecd9d5fbf84" default))
 '(package-selected-packages
   '(magit lsp-mode elpher yasnippet company geiser-racket evil-cleverparens parinfer-rust-mode undo-tree ligature linum-relative use-package modus-themes evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 113 :width normal)))))

;; =================

;; Remove toolbar
(tool-bar-mode 0)

;; Remove scroll bars
(scroll-bar-mode 0)

;; Start maximised
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; UTF 8!!!
(prefer-coding-system 'utf-8)

;; Bring up ibuffer instead of listing buffers.
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Remove yes-or-no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Tab width
(setq-default tab-width 4)


;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))


;; Relative + absolute current line nums.
(use-package linum-relative
  :config
  (setq linum-relative-current-symbol "")
  (setq linum-relative-backend 'display-line-numbers-mode)
  (linum-relative-global-mode))

(defun my-insert-tab ()
  "Insert literal tab."
  (interactive)
  (insert "\t"))


(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (my-insert-tab)))

;; Evil mode
(use-package evil
  :init
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  :config
  (setq evil-respect-visual-line-mode t)
  (evil-mode)
  (add-hook 'ibuffer-mode-hook 'evil-normal-state)
  (setq evil-want-C-i-jump nil)
  ;; Better navigation with visual line mode.
  (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
  ;; Better tab action
  (define-key evil-insert-state-map (kbd "TAB") 'indent-or-complete)
  ;; Xref in normal mode (not sure what M-. is meant to do in evil)
  (define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions))


;; Ido
(setq ido-everywhere t)
(ido-mode)


;; Font ligatures
(use-package ligature
  :config
  (ligature-set-ligatures t
                          '(("=" (rx (+ (or ">" "<" "|" "/" ":" "!" "=" "~"))))
                            ("-" (rx (+ (or ">" "<" "|" "~" "-" "+"))))
                            (";" (rx (+ ";")))
                            ("&" (rx (+ "&")))
                            ("!" (rx (+ (or "!" "." ":" "=" "~"))))
                            ("\\" (rx (or "/" "n" (+ "\\"))))
                            ("/" (rx (or "\\" "*" "=" (+ "/"))))
                            ("|" (rx (or "|" "=" "=")))
							("#" (rx (or "{" "(" "[" "_" "?" ":" "!" "=")))
							"#{}" "#_(" "}#"))

  ;; == === ==== => =< =| =/= =!= =:=  =<<=|=>>= =~
  ;; -- --- ---- -> -< -| -/- -!- -:-  -<<-|->>- -~
  ;; ;;;
  ;; && &&&
  ;; !! !!! !. !: != !== !~
  ;; != !==
  ;; \n \\
  ;; // /// /* */ /=
  ;; #{ #{} #( #[ #_ #_( #? #: #! #=
  
  (global-ligature-mode t))


;; Undo functionality
(use-package undo-tree
  :after evil
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))


;; Parinfer (NOTE: won't work with files containing tab char for some reason)
;;  Hopefully disabling electric-indent-mode will fix the manic tab behaviour
(use-package parinfer-rust-mode
  :hook '(scheme-mode)
  :config
  (define-key evil-insert-state-map (kbd "TAB") 'company-complete-common)
  (electric-indent-mode nil)
  (define-key parinfer-rust-mode-map (kbd "C-c C-p") 'parinfer-rust-toggle-paren-mode))

(add-hook 'scheme-mode #'(lambda () 
						  (electric-indent-mode nil)))

(use-package evil-cleverparens
  :hook '(scheme-mode lisp-mode))
