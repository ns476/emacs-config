(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(defun with-pkg (pkgname args)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (when (not (require pkgname nil t))
    (package-install pkgname)
    (require pkgname nil t))
  (eval args))

(defun add-pkgs ()
  (with-pkg 'zenburn-theme
            '())
  (with-pkg 'yaml-mode
            '())
  (with-pkg 'haskell-mode
            '(progn
               (add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))
               (add-hook 'haskell-mode-hook
                         'haskell-indentation-mode)
               (add-hook 'haskell-mode-hook
                         (lambda ()
                           (local-set-key "\C-x\C-s"
                                          (lambda ()
                                            (interactive)
                                            (save-buffer)
                                            (haskell-mode-stylish-buffer)
                                            (save-buffer)))))))

  (with-pkg 'flymake-hlint
            '(add-hook 'haskell-mode-hook 'flymake-hlint-load))
  (with-pkg 'ethan-wspace
            '(progn
               (set-variable 'require-final-newline nil)
               (set-variable 'mode-require-final-newline nil)
               (global-ethan-wspace-mode))))

(add-hook 'after-init-hook 'add-pkgs)

(setq inhibit-splash-screen t)

(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default indent-tabs-mode nil)

(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))

(menu-bar-mode 0)

(show-paren-mode 1)
