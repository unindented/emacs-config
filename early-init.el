;; -*- lexical-binding: t; no-byte-compile: t; -*-

(let ((emacs-version-min "30"))
  (when (version< emacs-version emacs-version-min)
    (error "This config requires Emacs v%s or higher." emacs-version-min)))


;;;; Performance
;;;; ---------------------------------------------------------------------------

;; Defer garbage collection further back in the startup process.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)

(add-hook 'emacs-startup-hook
          (lambda ()
            ;; Restore values.
            (setq gc-cons-threshold (* 1000 1000 8)
                  gc-cons-percentage 0.1)
            ;; Display startup time and number of GCs.
            (message "Emacs ready in %s with %d garbage collections."
                     (emacs-init-time "%.2f seconds")
                     gcs-done)))


;;;; Compilation
;;;; ---------------------------------------------------------------------------

;; Silence byte comp warnings.
(setq byte-compile-warnings
      '(not obsolete redefine))

(when (native-comp-available-p)
  ;; Silence native comp warnings.
  (setq native-comp-async-report-warnings-errors 'silent))


;;;; Package settings
;;;; ---------------------------------------------------------------------------

;; Defer package initialization.
(setq package-enable-at-startup nil)

;; Set before loading `use-package'.
(setq use-package-always-ensure nil
      use-package-always-defer nil
      use-package-expand-minimally t
      use-package-enable-imenu-support t)


;;;; Frame settings
;;;; ---------------------------------------------------------------------------

(mapc
 (lambda (frame-alist)
   ;; Maximize frames by default.
   (add-to-list frame-alist '(fullscreen . maximized))
   ;; On macOS, get rid of the title bar too.
   (when (eq system-type 'darwin)
     (add-to-list frame-alist '(undecorated-round . t))))
 '(initial-frame-alist default-frame-alist))

;; Minimal frame settings.
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      frame-title-format '("%b")
      ring-bell-function 'ignore
      use-dialog-box t
      use-file-dialog nil
      use-short-answers t
      inhibit-default-init t
      inhibit-startup-buffer-menu t
      inhibit-startup-screen t
      inhibit-x-resources t
      initial-scratch-message nil)

;; Disable these before they've been initialized.
(unless (and (display-graphic-p) (eq system-type 'darwin))
  (menu-bar-mode -1))
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

;; Name the default frame, so that we can easily select it.
(add-hook 'after-init-hook (lambda () (set-frame-name "home")))


;;;; Initial flash of light
;;;; ---------------------------------------------------------------------------

;; Set a dark background when starting Emacs, to avoid a flash of light.
(set-face-attribute
 'default nil :background "#0d0e1c" :foreground "#ffffff")
(set-face-attribute
 'mode-line nil :background "#0d0e1c" :foreground "#ffffff" :box 'unspecified)
;; Also hide mode line temporarily.
(setq mode-line-format nil)

(add-hook 'after-make-frame-functions
          (lambda (_frame)
            ;; Re-enable active theme, to restore everything.
            (when-let ((theme (car custom-enabled-themes)))
              (enable-theme theme))))


;;;; No littering
;;;; ---------------------------------------------------------------------------

(require 'xdg)

(defun my-xdg-expand (path base)
  "Expand PATH under the `emacs/' directory relative to BASE."
  (let* ((full-path (convert-standard-filename
                     (expand-file-name (concat "emacs/" path) (funcall base))))
         (dir (file-name-directory full-path)))
    (unless (file-directory-p dir)
      (make-directory dir t))
    full-path))

(defun my-xdg-cache (path) (my-xdg-expand path 'xdg-cache-home))
(defun my-xdg-data (path) (my-xdg-expand path 'xdg-data-home))
(defun my-xdg-state (path) (my-xdg-expand path 'xdg-state-home))

(defconst my-eln-cache-dir (my-xdg-cache "eln/"))

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache my-eln-cache-dir))
