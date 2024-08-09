;; -*- lexical-binding: t; -*-


;;;; Dired file manager
;;;; ---------------------------------------------------------------------------

(use-package dired
  :ensure nil
  :commands (dired)
  :config
  (setq dired-recursive-copies 'always
        dired-recursive-deletes 'always
        delete-by-moving-to-trash t))

;;;; ---------------------------------------------------------------------------

(provide 'init-dired)
