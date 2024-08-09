;; -*- lexical-binding: t; no-byte-compile: t; -*-

(let ((emacs-version-min "30"))
  (when (version< emacs-version emacs-version-min)
    (error "This config requires Emacs v%s or higher." emacs-version-min)))


;;; Performance

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


;;; Compilation

;; Silence confusing warnings.
(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))


;;; Package settings

;; Defer package initialization.
(setq package-enable-at-startup nil)

;; Set before loading `use-package'.
(setq use-package-always-ensure nil
      use-package-always-defer nil
      use-package-expand-minimally t
      use-package-enable-imenu-support t)


;;; Frame settings

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


;;; Initial flash of light

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


;;; Path

(defun my-exec-path-from-shell-get-path ()
  "Get the PATH environment variable from shell."
  (when (file-remote-p default-directory)
    (error "Cannot run from a remote buffer"))
  (with-temp-buffer
    (let* ((shell (getenv "SHELL"))
           (exit-code
            (call-process
             shell nil t nil
             "-l"
             "-c" "printf '%s' \"$PATH\"")))
      (unless (zerop exit-code)
        (error "Non-zero exit code from bash: %s" (buffer-string)))
      (buffer-string))))

(defun my-exec-path-from-shell-initialize ()
  "Initialize PATH from shell."
  (let ((path (my-exec-path-from-shell-get-path)))
    (setenv "PATH" path)
    (setq exec-path (append (parse-colon-path path) (list exec-directory)))
    (setq-default eshell-path-env path)))


;;; No littering

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
(defun my-xdg-config (path) (my-xdg-expand path 'xdg-config-home))
(defun my-xdg-data (path) (my-xdg-expand path 'xdg-data-home))
(defun my-xdg-state (path) (my-xdg-expand path 'xdg-state-home))

(when (and (fboundp 'startup-redirect-eln-cache)
           (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache (my-xdg-cache "eln/")))
