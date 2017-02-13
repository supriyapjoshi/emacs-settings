(setq inhibit-startup-message t)
(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 2)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; smart pairing for all
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode 1))

(use-package evil-smartparens
  :ensure t
  :config
  (evil-smartparens-mode 1))

(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)

;; disable annoying blink-matching-paren
(setq blink-matching-paren nil)

(global-hl-line-mode +1)

;; diminish keeps the modeline tidy
(require 'diminish)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package try
  :ensure t)

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode))

(use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    ))

(use-package company
  :ensure t
  :defer t
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


(evil-leader/set-leader ",")

(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(evil-leader/set-key
  "b" 'switch-to-buffer
  "r" 'split-window-right
  "n" 'other-window
  "h" 'split-window-below
  "u" 'undo-tree-visualize)

(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

(use-package cider
  :ensure t
  :config
  (setq cider-repl--help-banner nil))

(evil-leader/set-key
  "c" 'cider-connect)

(use-package magit
  :ensure t)

(evil-leader/set-key
  "gs" 'magit-status
  "gc" 'magit-commit
  "ga" 'magit-stage
  "gp" 'magit-pull
  "gf" 'magit-push)

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package clojure-mode
  :ensure t)

(use-package exec-path-from-shell
  :ensure t
  :defer t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package evil-mc
  :ensure t
  :config
  (evil-mc-mode 1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(my-carriage-return-face ((((class color)) (:background "blue"))) t)
 '(my-tab-face ((((class color)) (:background "green"))) t))
; add custom font locks to all buffers and all files
(add-hook
 'font-lock-mode-hook
 (function
  (lambda ()
    (setq
     font-lock-keywords
     (append
      font-lock-keywords
      '(
        ("\r" (0 'my-carriage-return-face t))
        ("\t" (0 'my-tab-face t))
        ))))))

; make characters after column 80 purple
(setq whitespace-style
  (quote (face trailing tab-mark lines-tail)))
(add-hook 'find-file-hook 'whitespace-mode)

; transform literal tabs into a right-pointing triangle
(setq
 whitespace-display-mappings ;http://ergoemacs.org/emacs/whitespace-mode.html
 '(
   (tab-mark 9 [9654 9] [92 9])
   ;others substitutions...
   ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default))))

(use-package powerline
  :ensure t)


(use-package smart-mode-line-powerline-theme
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :config
  (require 'powerline)
  (setq powerline-default-separator 'arrow-fade)
  (setq sml/theme 'powerline)
  (sml/setup)
  ;; These colors are more pleasing (for gruvbox)
  (custom-theme-set-faces
   'user
   '(powerline-evil-normal-face ((t (:inherit powerline-evil-base-face :background "chartreuse3"))))
   '(sml/folder ((t (:inherit sml/global :background "grey22" :foreground "grey50" :weight normal))) t)
   '(sml/git ((t (:background "grey22" :foreground "chartreuse3"))) t)))
