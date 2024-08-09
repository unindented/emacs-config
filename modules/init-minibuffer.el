;; -*- lexical-binding: t; -*-


;;; Minibuffer

(use-package vertico
  :ensure t
  :hook
  (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook
  (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides nil))

(use-package savehist
  :ensure nil
  :hook
  (after-init . savehist-mode)
  :config
  (setq history-length 100
        history-delete-duplicates t
        savehist-save-minibuffer-history t)
  (add-to-list 'savehist-additional-variables 'kill-ring))

(use-package corfu
  :ensure t
  :hook
  (after-init . global-corfu-mode)
  :bind
  ( :map corfu-map
    ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete
        corfu-preview-current nil
        corfu-min-width 20)
  ;; Show documentation after delay.
  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1)
  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package consult
  :ensure t
  :hook
  (completion-list-mode . consult-preview-at-point-mode)
  :bind
  ( :map global-map
    ("M-s M-b" . consult-buffer)
    ("M-s M-f" . consult-find)
    ("M-s M-g" . consult-grep)
    ("M-s M-l" . consult-line)
    ("M-s M-r" . consult-ripgrep)
    ("M-s M-s" . consult-outline)
    :map consult-narrow-map
    ("?" . consult-narrow-help)))

(use-package embark
  :ensure t
  :defer 1
  :bind
  ( :map global-map
    ("C-." . embark-act)
    ("C-;" . embark-dwim)
    ("C-h B" . embark-bindings)
    :map minibuffer-local-map
    ("C-c C-c" . embark-collect)
    ("C-c C-e" . embark-export)))

(use-package embark-consult
  :ensure t
  :after (embark consult))


(provide 'init-minibuffer)
