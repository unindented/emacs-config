;; -*- lexical-binding: t; -*-


;;; Programming

(use-package lispy
  :ensure t
  :hook
  ((emacs-lisp-mode . lispy-mode)
   (scheme-mode . lispy-mode)))


(provide 'init-programming)
