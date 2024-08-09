;; -*- lexical-binding: t; -*-


;;;; Essential configurations
;;;; ---------------------------------------------------------------------------

;; Auto-revert when file changes on disk.
(use-package autorevert
  :ensure nil
  :hook
  (after-init . global-auto-revert-mode))

;; Replace selection when typing.
(use-package delsel
  :ensure nil
  :hook
  (after-init . delete-selection-mode))

;; Display line numbers in all buffers.
(use-package display-line-numbers
  :ensure nil
  :hook
  (after-init . global-display-line-numbers-mode)
  :config
  ;; Avoid horizontal shift as you scroll down a file.
  (setq-default display-line-numbers-grow-only t
                display-line-numbers-width 2))

;; Enable line highlighting in all buffers.
(use-package hl-line
  :ensure nil
  :hook
  (after-init . global-hl-line-mode))

;; Keep track of opened files.
(use-package recentf
  :ensure nil
  :hook
  (after-init . recentf-mode)
  :config
  ;; Increase number of items.
  (setq recentf-max-menu-items 25
        recentf-max-saved-items 100))

;; Enable visual lines in all buffers.
(use-package simple
  :ensure nil
  :hook
  (after-init . global-visual-line-mode))

;; Display current time.
(use-package time
  :ensure nil
  :hook
  (after-init . display-time-mode)
  :config
  ;; Tweak formatting.
  (setq display-time-format " %a %b %e, %H:%M "
        display-time-day-and-date t
        display-time-24hr-format t
        display-time-interval 60
        display-time-default-load-average nil
        display-time-mail-directory nil
        display-time-mail-function nil
        display-time-mail-string nil
        display-time-mail-face nil
        display-time-use-mail-icon nil)
  ;; I don't need the load average nor the mail indicator.
  (setq display-time-string-forms
        '((if
              (and
               (not display-time-format)
               display-time-day-and-date)
              (format-time-string "%a %b %e " now)
            "")
          (propertize
           (format-time-string
            (or display-time-format
                (if display-time-24hr-format "%H:%M" "%-I:%M%p"))
            now)
           'help-echo
           (format-time-string "%a %b %e, %Y" now))
          " ")))

;; Display key bindings.
(use-package which-key
  :ensure nil
  :hook
  (after-init . which-key-mode)
  :config
  ;; Tweak visuals.
  (setq which-key-separator "  "
        which-key-prefix-prefix "... "
        which-key-add-column-padding 1))

;; Display whitespace in all buffers.
(use-package whitespace
  :ensure nil
  :hook
  (after-init . global-whitespace-mode)
  :bind
  (("<f6>" . global-whitespace-mode)
   ("C-c z" . delete-trailing-whitespace))
  :config
  ;; Customize which whitespace to show.
  (setq whitespace-style
        '(face
          trailing
          tabs
          spaces
          missing-newline-at-eof
          space-after-tab::tab
          space-after-tab::space
          space-before-tab::tab
          space-before-tab::space
          tab-mark
          space-mark))
  ;; Customize how different whitespace gets rendered.
  (setq whitespace-display-mappings
        '((space-mark 32 [183] [46])   ; sp to middle dot or period
          (space-mark 160 [9647] [95]) ; nbsp to rectangle or underscore
          (newline-mark 10 [36 10])    ; lf to dollar
          (tab-mark 9 [8594 9] [92 9]) ; tab to right arrow or backslash
          )))

;;;; ---------------------------------------------------------------------------

(provide 'init-essentials)
