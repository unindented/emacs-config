;; -*- lexical-binding: t; -*-


;;; Search

(use-package wgrep
  :ensure t
  :after grep
  :bind
  ( :map grep-mode-map
    ("e" . wgrep-change-to-wgrep-mode)
    ("C-x C-q" . wgrep-change-to-wgrep-mode)
    ("C-c C-c" . wgrep-finish-edit)))


(provide 'init-search)
