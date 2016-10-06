;;; feng.el - Customizaion
;;; Code:

;(setq debug-on-quit t)

;; (prelude-require-package 'org-mode)
(prelude-require-packages '(elscreen csv-mode dirtree mmm-mode php-mode markdown-mode rtags company))
(prelude-require-packages '(haskell-mode ghc haskell-emacs haskell-snippets shm flycheck-hdevtools)) ;haskell

(require 'prelude-ido)
(require 'prelude-c)
(require 'prelude-haskell)
(require 'prelude-helm)
(require 'prelude-helm-everywhere)
(require 'prelude-org)
(require 'prelude-python)
(require 'prelude-shell)
(require 'prelude-js)
(require 'prelude-emacs-lisp)

(eval-after-load "haskell-mode"
  '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(eval-after-load "haskell-cabal"
  '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

(global-linum-mode 1)                   ; add line numbers on the left

;; copy/paste with C-c and C-v and C-x, check out C-RET too
(cua-mode)

(server-start)

(load "desktop")
(setq desktop-load-locked-desktop t)
(desktop-save-mode 1)
(desktop-load-default)
(desktop-read)

;; scroll one line at a time (less "jumpy" than defaults)
;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2))) ;; two line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;(elscrene-set-prefix-key "\C-t")
;(setq elscreen-prefix-key "\C-q")
;(global-set-key (kbd "<S-prior>") 'elscreen-previous)
;(global-set-key (kbd "<S-next>") 'elscreen-next)
(require 'elscreen)
(setq elscreen-prefix-key "\C-t")
(elscreen-start)
(load "elsrecen" "ElScreen" t)
(global-set-key (kbd "<M-prior>") 'elscreen-previous)
(global-set-key (kbd "<M-next>") 'elscreen-next)
(global-set-key (kbd "<C-prior>") 'elscreen-previous)
(global-set-key (kbd "<C-next>") 'elscreen-next)

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

;; disable guru-mode
(setq prelude-guru nil)

(require 'dirtree)

(yas-global-mode)
(yas-reload-all)

(menu-bar-mode)

(setq projectile-enable-caching t)
; (setq prelude-whitespace nil)
; (set-default 'prelude-whitespace nil)



;; rtags
;; https://github.com/Andersbakken/rtags

;(require 'package)
;(package-initialize)

(require 'rtags)
(require 'company)
(require 'flycheck-rtags)

(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(push 'company-rtags company-backends)
(global-company-mode)
(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))

(defun use-rtags (&optional useFileManager)
  (and (rtags-executable-find "rc")
       (cond ((not (gtags-get-rootpath)) t)
             ((and (not (eq major-mode 'c++-mode))
                   (not (eq major-mode 'c-mode))) (rtags-has-filemanager))
             (useFileManager (rtags-has-filemanager))
             (t (rtags-is-indexed)))))

(defun tags-find-symbol-at-point (&optional prefix)
  (interactive "P")
  (if (and (not (rtags-find-symbol-at-point prefix)) rtags-last-request-not-indexed)
      (gtags-find-tag)))
(defun tags-find-references-at-point (&optional prefix)
  (interactive "P")
  (if (and (not (rtags-find-references-at-point prefix)) rtags-last-request-not-indexed)
      (gtags-find-rtag)))
(defun tags-find-symbol ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-symbol 'gtags-find-symbol)))
(defun tags-find-references ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-references 'gtags-find-rtag)))
(defun tags-find-file ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-find-file 'gtags-find-file)))
(defun tags-imenu ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-imenu 'idomenu)))

(custom-set-variables '(sp-override-key-bindings (quote (("C-M-f") ("C-M-b")))))

(define-key c-mode-base-map (kbd "M-.") (function tags-find-symbol-at-point))
(define-key c-mode-base-map (kbd "M-,") (function tags-find-references-at-point))
(define-key c-mode-base-map (kbd "M-;") (function tags-find-file))
(define-key c-mode-base-map (kbd "C-.") (function tags-find-symbol))
(define-key c-mode-base-map (kbd "C-,") (function tags-find-references))
(define-key c-mode-base-map (kbd "C-<") (function rtags-find-virtuals-at-point))
(define-key c-mode-base-map (kbd "M-i") (function tags-imenu))
(define-key c-mode-base-map (kbd "C-M-b") (function rtags-location-stack-back))
(define-key c-mode-base-map (kbd "C-M-f") (function rtags-location-stack-forward))
(define-key c-mode-base-map (kbd "C-M-S-r") (function rtags-find-all-references-at-point))

(define-key global-map (kbd "M-.") (function tags-find-symbol-at-point))
(define-key global-map (kbd "M-,") (function tags-find-references-at-point))
(define-key global-map (kbd "M-;") (function tags-find-file))
(define-key global-map (kbd "C-.") (function tags-find-symbol))
(define-key global-map (kbd "C-,") (function tags-find-references))
(define-key global-map (kbd "C-<") (function rtags-find-virtuals-at-point))
(define-key global-map (kbd "M-i") (function tags-imenu))


;(require 'package)
;(package-initialize)
(require 'rtags)
(require 'company)

(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(push 'company-rtags company-backends)
(global-company-mode)
(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))

(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++-mode
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

(rtags-enable-standard-keybindings c-mode-base-map "\C-cr")

(setq rtags-close-taglist-on-selection t)
(setq rtags-find-file-case-insensitive t)
;(custom-set-variables '(rtags-close-taglist-on-selection nil))
;or you can just use setq, since the variable doesn't have a setter defined:
;(setq cperl-indent-parens-as-block t)
