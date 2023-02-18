;; ======================================================================
;; User functions
;; ======================================================================

(defun my-insert-tab ()
  "Insert literal tab."
  (interactive)
  (insert "\t"))

(defun complete-or-indent ()
  "Checks if completion is enabled, if not inserts tab char."
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (my-insert-tab)))

(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (my-insert-tab)))

(defun multi-add-hook (mode-hooks function)
  "Allows to add a hook to a list of modes."
  (mapc (lambda (mode-hook)
          (add-hook mode-hook function))
        mode-hooks))


;; ======================================================================
;; Auto config
;; ======================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-operandi-tinted))
 '(custom-safe-themes
   '("986cdc701d133f7c6b596f06ab5c847bebdd53eb6bc5992e90446d2ddff2ad9e" "71ac1434a07579da9b1ec1dd1a2b9cfa3182523d750678b68db6c25749fb6494" "da9b96cf5566f626ac18d4a3a33159624b8ea92349b47223bf17af6c904893af" "cd80f569cdd67056b414923f67e3ea4c952876b7f0398b6dd3bb76cad0d6a2d5" "1752a799b84cf9897f7c97bb16a139d77cf76b008209d246a35793c23f58dff4"))
 '(package-selected-packages
   '(yasnippet lsp-mode tree-sitter-langs tree-sitter use-package undo-tree sly rainbow-delimiters parinfer-rust-mode multiple-cursors modus-themes magit linum-relative ligature highlight-indent-guides geiser-racket evil-multiedit evil-mc company-jedi)))
'("76f5d6ce2d1792142231cab87260e526db3f8a542c9aaf36fa8e98ea3a339235" "31c0444ad6f28f6d0d6594add71a8960bf5a29f14f0c1e9e5a080b41f6149277" "cd80f569cdd67056b414923f67e3ea4c952876b7f0398b6dd3bb76cad0d6a2d5" "5fdc0f5fea841aff2ef6a75e3af0ce4b84389f42e57a93edc3320ac15337dc10" "986cdc701d133f7c6b596f06ab5c847bebdd53eb6bc5992e90446d2ddff2ad9e" default
      '(inferior-lisp-program "c:/Program Files/Steel Bank Common Lisp/sbcl.exe")
      '(org-agenda-files '("c:/Users/LeeThompson/Notes.org"))
      '(package-selected-packages
        '(modus-themes geiser-racket evil-multiedit evil-mc multiple-cursors parinfer-rust-mode undo-tree use-package highlight-indent-guides sly ligature company-jedi company magit rainbow-delimiters linum-relative evil))
      '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Cascadia Code Regular" :foundry "outline" :slant normal :weight normal :height 102 :width normal)))))

;; ======================================================================
;; Manual config
;; ======================================================================

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


;; Text mode
(add-hook 'text-mode-hook
      (lambda ()
            (define-key text-mode-map (kbd "TAB") 'my-insert-tab)))
(add-hook 'text-mode-hook
      (company-mode nil))

;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))


;; Relative + absolute current line nums.
(use-package linum-relative
  :config
  (setq linum-relative-current-symbol "")
  (setq linum-relative-backend 'display-line-numbers-mode)
  (linum-relative-global-mode))


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


;; Rainbow parens.
(require 'rainbow-delimiters)
(rainbow-delimiters-mode)


;; Kill buffer without confirmation.
(defun kill-this-buffer-volatile ()
  "Uncoditionally kill buffer."
  (interactive)
  (let ((buffer-modified-p nil))
    (kill-buffer (current-buffer))))

(global-set-key (kbd "C-x k") 'kill-this-buffer-volatile)




;; Company mode settings
(use-package company
  :config
  (global-company-mode)
  (company-tng-configure-default)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))


;; Python settings
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True")


;; Org mode
(add-hook 'org-mode-hook 'visual-line-mode)

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
                            ("|" (rx (or "|" "=" "=")))))

  ;; == === ==== => =< =| =/= =!= =:=  =<<=|=>>= =~
  ;; -- --- ---- -> -< -| -/- -!- -:-  -<<-|->>- -~
  ;; ;;;
  ;; && &&&
  ;; !! !!! !. !: != !== !~
  ;; != !==
  ;; \n \\
  ;; // /// /* */ /=
  
  (global-ligature-mode t))

;; Indent guides
(highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)

(setq initial-buffer-choice "c:/Users/LeeThompson/Notes.org")

;; Undo functionality
(use-package undo-tree
  :after evil
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

;; Display fill column (80 chars)
(use-package display-fill-column-indicator
  :hook
  (emacs-lisp-mode
   c-mode
   python-mode)
  :config
  (setq fill-column 90)
  (set-face-attribute 'fill-column-indicator nil :foreground "grey90")
  (setq column-number-mode t)) ;; Not needed here but fits thematically


;; Parinfer (NOTE: won't work with files containing tab char for some reason)
;;  Hopefully disabling electric-indent-mode will fix the manic tab behaviour
(use-package parinfer-rust-mode
  :hook '(emacs-lisp-mode scheme-mode)
  :config
  (electric-indent-mode nil)
  (define-key parinfer-rust-mode-map (kbd "C-c C-p") 'parinfer-rust-toggle-paren-mode))
  
;; Multi cursors
(use-package evil-multiedit
  :config
  (define-key evil-normal-state-map (kbd "C->") 'evil-multiedit-match-symbol-and-next)
  (define-key evil-normal-state-map (kbd "C-<") 'evil-multiedit-match-symbol-and-prev))


;; Tree sitter syntax highlighting
(use-package tree-sitter
  :hook '(c-mode python-mode)
  :config
  (tree-sitter-hl-mode)
  (global-tree-sitter-mode))


;; Adds a multi hook to set the fill-column for a few modes to 90
(multi-add-hook
 '(emacs-lisp-mode-hook
   org-mode-hook
   c-mode-hook
   python-mode-hook)
 (lambda () (setq fill-column 90)))


;; C Mode
(add-hook 'c-mode-hook 'lsp)
(setq-default c-default-style "linux")
(setq-default c-basic-offset 4)

;; Yasnippet
(defun my-yas-auto ()
  (when yas-minor-mode
	(let ((yas-buffer-local-condition '(require-snippet-condition . auto)))
	  (yas-expand))))
(add-hook 'post-command-hook #'my-yas-auto)
  
  
