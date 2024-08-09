;; -*- lexical-binding: t -*-


;;;; No littering (cont.)
;;;; ---------------------------------------------------------------------------

(defconst my-auto-save-list-dir (my-xdg-data "auto-save/sessions/"))
(defconst my-auto-save-dir (my-xdg-data "auto-save/"))
(defconst my-backups-dir (my-xdg-data "backups/"))
(defconst my-bookmarks-file (my-xdg-data "bookmarks.el"))
(defconst my-custom-file (my-xdg-data "custom.el"))
(defconst my-desktop-dir (my-xdg-data "desktop/"))
(defconst my-fontaine-state-file (my-xdg-state "fontaine.eld"))
(defconst my-locks-dir (my-xdg-data "locks/"))
(defconst my-recentf-file (my-xdg-data "recentf.el"))
(defconst my-savehist-file (my-xdg-data "history.el"))
(defconst my-packages-dir (my-xdg-cache "packages/"))

(setq auto-save-list-file-prefix my-auto-save-list-dir
      auto-save-file-name-transforms `((".*" ,my-auto-save-dir t))
      backup-directory-alist `((".*" . ,my-backups-dir))
      bookmark-default-file my-bookmarks-file
      custom-file my-custom-file
      desktop-dirname my-desktop-dir
      desktop-path (list my-desktop-dir)
      fontaine-latest-state-file my-fontaine-state-file
      lock-file-name-transforms `((".*" ,my-locks-dir t))
      recentf-save-file my-recentf-file
      savehist-file my-savehist-file
      package-user-dir my-packages-dir)

(setq create-lockfiles nil)


;;;; Misc stuff
;;;; ---------------------------------------------------------------------------

(setq user-full-name "Daniel Perez Alvarez"
      user-mail-address "daniel@unindented.org")

;; Don't try this at home!
(setq enable-local-variables :all)


;;;; Modules
;;;; ---------------------------------------------------------------------------

(mapc
 (lambda (path)
   (push (locate-user-emacs-file path) load-path))
 '("modules"))

(require 'init-package)
(require 'init-appearance)
(require 'init-essentials)
(require 'init-completion)
(require 'init-dired)
(require 'init-git)
(require 'init-writing)
