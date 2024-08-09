;; -*- lexical-binding: t; -*-


;;;; Appearance
;;;; ---------------------------------------------------------------------------

(setq custom-safe-themes t)

(use-package modus-themes
  :ensure t
  :demand t
  :bind (("<f5>" . modus-themes-toggle)
         ("C-<f5>" . modus-themes-select))
  :config
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)
  ;; Use tinted.
  (setq modus-themes-common-palette-overrides modus-themes-preset-overrides-faint)
  ;; Toggle between light and dark.
  (setq modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))
  ;; Load the last theme (dark).
  (modus-themes-load-theme (cadr modus-themes-to-toggle)))

(use-package spacious-padding
  :ensure t
  :if (display-graphic-p)
  :hook (after-init . spacious-padding-mode)
  :config
  (setq spacious-padding-subtle-mode-line t))

(use-package fontaine
  :ensure t
  :if (display-graphic-p)
  :hook
  ;; Persist the latest font preset when closing/starting Emacs and while
  ;; switching between themes.
  ((after-init . fontaine-mode)
   (after-init . (lambda ()
                   (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular)))))
  :bind ("C-c f" . fontaine-set-preset)
  :config
  (setq fontaine-presets
        '((regular)
          (large
           :default-height 200)
          (t
           :default-height 165
           :default-family "Cascadia Code"
           :fixed-pitch-family "Cascadia Code"
           :variable-pitch-family "SF Pro"))))

;;;; ---------------------------------------------------------------------------

(provide 'init-appearance)
