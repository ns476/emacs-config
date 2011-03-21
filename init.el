;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/")

;;; Color theme stuff
(when window-system
  (require 'color-theme)
  (require 'zenburn)
  (zenburn))

;;; much better than term.el
(require 'multi-term)
  
;;; No tool bar or scroll bar
(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(when (not window-system)
  (menu-bar-mode 0))

;;; or initialisation screen..
(setq inhibit-startup-screen 1)

;;; Line numbers
(global-linum-mode 1)

;;; Get out of bad habits

(global-unset-key [up])
(global-unset-key [down])
(global-unset-key [left])
(global-unset-key [right])

(global-unset-key [prior])
(global-unset-key [next])

(global-set-key [up] 'windmove-up)
(global-set-key [down] 'windmove-down)
(global-set-key [left] 'windmove-left)
(global-set-key [right] 'windmove-right)

;;; A few modes
(require 'yaml-mode)
(require 'css-mode)
(require 'sml-mode)

(load "javascript.el")
(load "markdown-mode.el")

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "linux")
	    (highlight-parentheses-mode)
	    (local-set-key (kbd "RET") 'newline-and-indent)))

;;; Use a server

;;; Allow interactive macros
    (defun my-macro-query (arg)
      "Prompt for input using minibuffer during kbd macro execution.
    With prefix argument, allows you to select what prompt string to use.
    If the input is non-empty, it is inserted at point."
      (interactive "P")
      (let* ((query (lambda () (kbd-macro-query t)))
             (prompt (if arg (read-from-minibuffer "PROMPT: ") "Input: "))
             (input (unwind-protect
                        (progn
                          (add-hook 'minibuffer-setup-hook query)
                          (read-from-minibuffer prompt))
                      (remove-hook 'minibuffer-setup-hook query))))
        (unless (string= "" input) (insert input))))

    (global-set-key "\C-xQ" 'my-macro-query)


;; Haskell stuff

(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hic?$"     . haskell-mode)
                ("\\.hsc$"     . haskell-mode)
  ("\\.chs$"    . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t)

;adding the following lines according to which modules you want to use:
(require 'inf-haskell)

(add-hook 'haskell-mode-hook 'turn-on-font-lock)
;(add-hook 'haskell-mode-hook 'turn-off-haskell-decl-scan)
;(add-hook 'haskell-mode-hook 'turn-off-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 
   (function
    (lambda ()
      (setq haskell-program-name "ghci")
      (setq haskell-ghci-program-name "ghci6"))))

;; end Haskell stuff