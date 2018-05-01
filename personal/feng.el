;;; feng.el - Customizaion
;;; Code:

;(setq debug-on-quit t)

;(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(setenv "PATH" (concat (getenv "PATH") ":/proj/epg-tools/clang/4.0.1/bin/"))
(setq exec-path (append exec-path '("/proj/epg-tools/clang/4.0.1/bin/")))

;; (prelude-require-package 'org-mode)
(prelude-require-packages '(elscreen csv-mode dirtree mmm-mode php-mode markdown-mode company plantuml-mode))
(prelude-require-packages '(haskell-mode ghc haskell-emacs haskell-snippets shm flycheck-hdevtools)) ;haskell
(prelude-require-packages '(ws-butler dtrt-indent sr-speedbar flycheck 0blayout neotree jump-tree))
(prelude-require-packages '(rtags flycheck-rtags company-rtags helm-rtags)) ;rtags
(prelude-require-packages '(lsp-mode lsp-ui cquery company company-lsp)) ; cquery
(prelude-require-packages '(zeal-at-point helm-dash frames-only-mode))
;(prelude-require-packages '(project-explorer window-purpose zoom))
;(prelude-require-packages '(use-package lsp-mode))

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
(global-auto-revert-mode t)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-;") nil))

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

;(require 'zoom)
;(custom-set-variables
; '(zoom-mode t))
;(custom-set-variables
; '(zoom-size '(0.618 . 0.618)))

;(defun size-callback ()
;  (cond ((> (frame-pixel-width) 1280) '(90 . 0.75))
;        (t                            '(0.5 . 0.5))))

;(custom-set-variables
; '(zoom-size 'size-callback))

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
;(require 'sourcetrail)
;sourcetrail-mode

;(require 'window-purpose)
;(purpose-mode)

(menu-bar-mode -1)
(scroll-bar-mode -1)

(tool-bar-mode -1)

(tool-bar-add-item "left-arrow" 'rtags-location-stack-back
                   'rtags-location-stack-back
                   :help   "rtags-location-stack-back")
(tool-bar-add-item "right-arrow" 'rtags-location-stack-forward
                   'rtags-location-stack-forward
                   :help   "rtags-location-stack-forward")

(tool-bar-add-item "describe" 'rtags-find-symbol-at-point
                   'rtags-find-symbol-at-point
                   :help   "rtags-find-symbol-at-point")
(tool-bar-add-item "index" 'rtags-find-references-at-point
                   'rtags-find-references-at-point
                   :help   "rtags-find-references-at-point")
(tool-bar-add-item "index" 'rtags-find-all-references-at-point
                   'rtags-find-all-references-at-point
                   :help   "rtags-find-all-references-at-point")
(tool-bar-add-item "index" 'rtags-find-file
                   'rtags-find-file
                   :help   "rtags-find-file")
(tool-bar-add-item "index" 'rtags-show-rtags-buffer
                   'rtags-show-rtags-buffer
                   :help   "rtags-show-rtags-buffer")
(tool-bar-add-item "index" 'rtags-taglist
                   'rtags-taglist
                   :help   "rtags-taglist")

(tool-bar-add-item "refresh" 'rtags-reparse-file
                   'rtags-reparse-file
                   :help   "rtags-reparse-file")

(tool-bar-add-item "index" 'desktop-save
                   'desktop-save
                   :help   "desktop-save")


(require 'cquery)
(require 'lsp-mode)
(require 'lsp-ui)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(setq cquery-executable "/home/feng/w/cpp/cquery/build/debug/bin/cquery")
;(setq cquery-executable "/home/ezfenxi/w/cpp/cquery/build/debug/bin/cquery")
;(setq cquery-executable "/home/ezfenxi/w/cpp/cquery/build/release/bin/cquery")

;; Log file
(setq cquery-extra-args '("--log-file=/home/feng/cquery.log"))
;(setq cquery-extra-args '("--log-file=/workspace/git/ezfenxi/cquery.log"))
;; Initialization options
;; (setq cquery-extra-init-params '())
;(setq cquery-extra-init-params '(:cacheDirectory "/workspace/git/ezfenxi/cquery-cache/epg"))
;(setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack" :cacheDirectory "/workspace/git/ezfenxi/cquery-cache/epg_emacs"))
(setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack" :completion (:detailedLabel t)))

(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

(add-hook 'c-mode-hook #'lsp-cquery-enable)
(add-hook 'c++-mode-hook #'lsp-cquery-enable)
(add-hook 'objc-mode-hook #'lsp-cquery-enable)

;;(define-key evil-normal-state-map (kbd "C-p") 'lsp-ui-peek-jump-forward)
;;(define-key evil-normal-state-map (kbd "C-t") 'lsp-ui-peek-jump-backward)

;; (cquery-xref-find-custom "$cquery/base")
;; (cquery-xref-find-custom "$cquery/callers")
;; (cquery-xref-find-custom "$cquery/derived")
;; (cquery-xref-find-custom "$cquery/vars")

;; Alternatively, use lsp-ui-peek interface
;; (lsp-ui-peek-find-custom 'base "$cquery/base")
;; (lsp-ui-peek-find-custom 'callers "$cquery/callers")
;; (lsp-ui-peek-find-custom 'random "$cquery/random") ;; jump to a random declaration

; Completion
(require 'company-lsp)
(push 'company-lsp company-backends)
(setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)

;;(setq cquery-extra-init-params '(:completion (:detailedLabel t)))

; Semantic highlighting
(setq cquery-sem-highlight-method 'font-lock)
;; alternatively, (setq cquery-sem-highlight-method 'overlay)

;; For rainbow semantic highlighting
(cquery-use-default-rainbow-sem-highlight)


;; Port of Coderush's smart semi-colon feature to Emacs
;; When I hit semi-colon anywhere, Emacs will move cursor to the end of current
;; line and insert semi-colon (if it's not already there).
;; Idea from last @CoderetreatCZ - HK

(defun maio/electric-semicolon ()
  (interactive)
  (end-of-line)
  (when (not (looking-back ";"))
    (insert ";"))
  (newline-and-indent))

;(define-key c-mode-base-map (kbd "<C-S-return>") 'maio/electric-semicolon)
;(define-key c-mode-base-map (kbd "<C-M-return>") 'maio/electric-semicolon)
;(define-key c-mode-base-map (kbd "<M-return>") 'maio/electric-semicolon)
(define-key c-mode-base-map (kbd "C-;") 'maio/electric-semicolon)

;(define-key c-mode-base-map (kbd "<tab>") 'clang-format-region)

(setq helm-dash-browser-func 'eww)

(defun bjm/kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'bjm/kill-this-buffer)

(global-set-key (kbd "C-x w") 'delete-frame)

(frames-only-mode)
