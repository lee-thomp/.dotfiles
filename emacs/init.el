(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(ligature company-jedi company magit rainbow-delimiters linum-relative evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code Medium" :foundry "outline" :slant normal :weight normal :height 102 :width normal)))))


;; Remove toolbar
(tool-bar-mode 0)


;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))


;; Relative + absolute current line nums.
(require 'linum-relative)
(setq linum-relative-current-symbol "")
(linum-relative-global-mode)


;; Evil mode
(require 'evil)
(evil-mode)
(add-hook 'ibuffer-mode-hook 'evil-normal-state)
;(define-key evil-normal-state-map (kbd ",") 'execute-extended-command)


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


;; Tab settings
(defun my-insert-tab ()
  "Insert literal tab."
  (interactive)
  (insert "\t"))

(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))

(global-set-key (kbd "TAB") 'complete-or-indent)
(setq tab-width 4)


;; Python settings
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True")


;; Font ligatures
(ligature-set-ligatures t '("www"))
(ligature-set-ligatures '(emacs-lisp-mode)
			'(;; == === ==== => =| =>>=||=<=>=>>=
			  ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "="))))))
(global-ligature-mode t)
