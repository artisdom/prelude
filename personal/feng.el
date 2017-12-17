;;; feng.el - Customizaion
;;; Code:

;(setq debug-on-quit t)

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(setenv "PATH" (concat (getenv "PATH") ":/proj/epg-tools/clang/5.0.0/bin/"))
(setq exec-path (append exec-path '("/proj/epg-tools/clang/5.0.0/bin/")))

;; (prelude-require-package 'org-mode)
(prelude-require-packages '(elscreen csv-mode dirtree mmm-mode php-mode markdown-mode company zoom plantuml-mode))
(prelude-require-packages '(haskell-mode ghc haskell-emacs haskell-snippets shm flycheck-hdevtools)) ;haskell
(prelude-require-packages '(ws-butler dtrt-indent sr-speedbar flycheck 0blayout neotree jump-tree sourcetrail))
(prelude-require-packages '(rtags flycheck-rtags company-rtags helm-rtags)) ;rtags

;sourcetrail

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

(global-linum-mode 1)                   ; add line numbers on the left

;; copy/paste with C-c and C-v and C-x, check out C-RET too
(cua-mode)

(server-start)

(load "desktop")
(desktop-save-mode 1)
;(desktop-load-default)
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

;(require 'package)
;(package-initialize)

(defun open-atom ()
  (interactive)
  (call-process
   "atom" nil t nil buffer-file-name))

(when (require 'edit-server nil t)
  (setq edit-server-new-frame nil)
  (edit-server-start))

(require 'zoom)
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

(require 'sr-speedbar)

(setq
 sr-speedbar-width 15
 sr-speedbar-max-width 15
 speedbar-use-images nil
 speedbar-show-unknown-files t
 sr-speedbar-right-side nil
)

(require 'neotree)
(require 'jump-tree)
(require 'sourcetrail)
;sourcetrail-mode
