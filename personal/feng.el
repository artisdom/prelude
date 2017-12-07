;;; feng.el - Customizaion
;;; Code:

;(setq debug-on-quit t)

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; (prelude-require-package 'org-mode)
(prelude-require-packages '(elscreen csv-mode dirtree mmm-mode php-mode markdown-mode company zoom plantuml-mode))
(prelude-require-packages '(haskell-mode ghc haskell-emacs haskell-snippets shm flycheck-hdevtools flycheck-rtags)) ;haskell
(prelude-require-packages '(ws-butler dtrt-indent sr-speedbar helm-rtags irony company-irony company-irony-c-headers flycheck flycheck-rtags flycheck-irony company-rtags cmake-ide))

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
;(desktop-save-mode 1)
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
;(setq prelude-whitespace nil)


;; rtags

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

(define-key c-mode-base-map (kbd "M-.") (function tags-find-symbol-at-point))
(define-key c-mode-base-map (kbd "M-,") (function tags-find-references-at-point))
(define-key c-mode-base-map (kbd "M-;") (function tags-find-file))
(define-key c-mode-base-map (kbd "C-.") (function tags-find-symbol))
(define-key c-mode-base-map (kbd "C-,") (function tags-find-references))
(define-key c-mode-base-map (kbd "C-<") (function rtags-find-virtuals-at-point))
(define-key c-mode-base-map (kbd "M-i") (function tags-imenu))

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
(require 'company-rtags)

(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(global-company-mode)
(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))

(require 'helm-rtags)
(setq rtags-use-helm t)


(require 'irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


(require 'company-irony)
(require 'company-irony-c-headers)

(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

(setq company-idle-delay 0)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)


(require 'flycheck)
(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  "Configure flycheck-rtags for better experience."
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-check-syntax-automatically nil)
  (setq-local flycheck-highlighting-mode nil))
(add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)

(rtags-enable-standard-keybindings c-mode-base-map "\C-cr")

(setq rtags-close-taglist-on-selection t)
(setq rtags-find-file-case-insensitive t)
;(custom-set-variables '(rtags-close-taglist-on-selection nil))
;or you can just use setq, since the variable doesn't have a setter defined:
;(setq cperl-indent-parens-as-block t)


(require 'flycheck-irony)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


(setenv "PATH" (concat (getenv "PATH") ":/home/ezfenxi/w/cpp/rtags/build/bin/:/home/ezfenxi/cpp/clang/build/bin"))
(setq exec-path (append exec-path '("/home/ezfenxi/w/cpp/rtags/build/bin/")))
(setq exec-path (append exec-path '("/home/ezfenxi/cpp/clang/build/bin")))

(defun open-atom ()
  (interactive)
  (call-process
   "atom" nil t nil buffer-file-name))

(when (require 'edit-server nil t)
  (setq edit-server-new-frame nil)
  (edit-server-start))

(custom-set-variables
 '(zoom-mode t))
;(custom-set-variables
; '(zoom-size '(0.618 . 0.618)))

(defun size-callback ()
  (cond ((> (frame-pixel-width) 1280) '(90 . 0.75))
        (t                            '(0.5 . 0.5))))

(custom-set-variables
 '(zoom-size 'size-callback))

;(prefer-coding-system 'utf-8)
;(set-default-coding-systems 'utf-8)
;(set-language-environment 'utf-8)
;(set-selection-coding-system 'utf-8)

;(let ((coding-system-for-read 'no-conversion)))
(let ((coding-system-for-write 'utf-8)))

(require 'dtrt-indent)
(dtrt-indent-mode 1)
(setq dtrt-indent-verbosity 0)

(require 'ws-butler)
(add-hook 'c-mode-common-hook 'ws-butler-mode)

(setq speedbar-show-unknown-files t)

(require 'cmake-ide)
(cmake-ide-setup)
