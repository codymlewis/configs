;;; Package --- Summary
;;; Commentary:
;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (vterm mingus w3m emms symon ess indent-guide diff-hl-mode magit goto-line-preview anzu tron-legacy-theme telephone-line auto-complete-auctex pdf-tools god-mode rainbow-delimiters yasnippet-snippets flycheck olivetti auto-complete dracula-theme aggressive-indent auctex helm use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(fringe-mode 1)
(ido-mode t)

(server-start)

(electric-pair-mode)
(prettify-symbols-mode)
(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-h") 'left-char)
(global-set-key (kbd "C-l") 'right-char)
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-k") 'previous-line)

(require 'package)
					;(eval-when-compile
					;  (require 'use-package))


(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(use-package grandshell-theme
  :ensure t
  :config
  (load-theme 'grandshell t))

(use-package telephone-line
  :ensure t
  :init
  (telephone-line-mode 1))

(use-package vterm
  :ensure t
  :bind
  (("C-x t" . vterm)))

(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  :bind
  (("C-x C-f" . helm-find-files)
   ("M-x" . helm-M-x)
   ([f10] . helm-buffers-list)))

(use-package anzu
  :ensure t
  :init
  (global-anzu-mode +1))

(use-package goto-line-preview
  :ensure t
  :bind
  (("M-g M-g" . goto-line-preview)))

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (global-auto-complete-mode))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode))

(use-package yasnippet-snippets
  :ensure t)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

(use-package magit
  :ensure t
  :bind
  (("C-x g" . magit)))

(use-package diff-hl
  :ensure t
  :after (magit)
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package symon
  :ensure t
  :init
  (symon-mode))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package indent-guide
  :ensure t
  :init
  (indent-guide-global-mode))

(use-package pdf-tools
  :ensure t
  :init
  (pdf-tools-install))

(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :after (pdf-tools)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook
	    (lambda ()
	      (setq TeX-PDF-mode t)
	      (setq TeX-source-correlate-mode t)
	      (setq TeX-source-correlate-start-server t)))
  (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook #'TeX-revert-document-buffer)
  (add-hook 'LaTeX-mode-hook 'pdf-tools-install)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")) TeX-source-correlate-start-server t)
  (setq TeX-view-program-list '(("PDF Tools" "TeX-pdf-tools-sync-view"))))

(use-package ess-site
  :ensure ess)

(use-package reftex
  :ensure t
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex))

(use-package auto-complete-auctex
  :ensure t)

(use-package aggressive-indent
  :ensure t
  :init
  (global-aggressive-indent-mode 1))

(use-package god-mode
  :ensure t
  :bind
  ("<escape>" . god-local-mode))

(use-package w3m
  :ensure t)

(use-package mingus
  :ensure t
  :bind
  (("M-n" . mingus)))

;;; .emacs ends here
