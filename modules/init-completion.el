;; -*- lexical-binding: t; -*-


;;;; Completion
;;;; ---------------------------------------------------------------------------

(use-package savehist
  :ensure nil
  :hook
  (after-init . savehist-mode)
  :config
  (setq history-length 100
        history-delete-duplicates t)
  (setq savehist-save-minibuffer-history t)
  (add-to-list 'savehist-additional-variables 'kill-ring))

;;;; ---------------------------------------------------------------------------

(provide 'init-completion)
