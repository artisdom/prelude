;(prelude-require-packages '(company-ycmd ycmd flycheck-ycmd irony company-irony company-irony-c-headers flycheck-irony cmake-ide))

;; (setenv "PATH" (concat (getenv "PATH") ":/home/ezfenxi/w/cpp/rtags/build/bin/:/proj/epg-tools/clang/5.0.0/bin/"))
;; (setq exec-path (append exec-path '("/home/ezfenxi/w/cpp/rtags/build/bin/")))
;;                                         ;(setq exec-path (append exec-path '("/home/ezfenxi/cpp/clang/build/bin")))
;; (setq exec-path (append exec-path '("/proj/epg-tools/clang/5.0.0/bin/")))


;; (eval-after-load "haskell-mode"
;;   '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
;; (eval-after-load "haskell-cabal"
;;   '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))


; disable irony on large codebases, for it's too slow.
;; (require 'irony)

;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; (defun my-irony-mode-hook ()
;;   (define-key irony-mode-map [remap completion-at-point]
;;     'irony-completion-at-point-async)
;;   (define-key irony-mode-map [remap complete-symbol]
;;     'irony-completion-at-point-async))

;; (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;; (require 'company-irony)
;; (require 'company-irony-c-headers)

;; (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;; (setq company-backends (delete 'company-semantic company-backends))
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends '(company-irony-c-headers company-irony)))

;; (setq company-idle-delay 0)
;; (define-key c-mode-map [(tab)] 'company-complete)
;; (define-key c++-mode-map [(tab)] 'company-complete)

;; (require 'flycheck-irony)
;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

                                        ; (require 'cmake-ide)
                                        ; (cmake-ide-setup)

                                        ; ycmd
                                        ;(require 'ycmd)
                                        ;(add-hook 'after-init-hook #'global-ycmd-mode)

;;;; Specify only support c/c++ mode
;;(require 'ycmd)
;;(add-hook 'c++-mode-hook 'company-mode)
;;(add-hook 'c++-mode-hook 'ycmd-mode)

;;;; Specify how to run the server
                                        ;(set-variable 'ycmd-server-command '("/app/python/2.7.1/RHEL64/bin/python" "/home/ezfenxi/w/cpp/ycmd/ycmd"))

;;;; Specify a global emacs configuration
                                        ; (set-variable 'ycmd-global-config "/home/cobbliu/ycmd/examples/.ycm_extra_conf.py")

;;;; Completion framework
                                        ;(require 'company-ycmd)
                                        ;(company-ycmd-setup)
                                        ;(add-hook 'after-init-hook #'global-company-mode)

;;;; Enable flycheck
                                        ;(require 'flycheck-ycmd)
                                        ;(flycheck-ycmd-setup)
                                        ;(add-hook 'after-init-hook #'global-flycheck-mode)
