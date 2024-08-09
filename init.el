;; -*- lexical-binding: t -*-


;;; General

(setq user-full-name "Daniel Perez Alvarez"
      user-mail-address "daniel@unindented.org")

;; Don't try this at home!
(setq enable-local-variables :all)

;; It seems like the approach Emacs Plus takes to solve `PATH' issues
;; (injecting it into the app's =Info.plist= at build time) has stopped
;; working around Sequoia:
;; https://github.com/d12frosted/homebrew-emacs-plus/issues/720
;; I'm falling back to copying it from the shell, using a simplified version
;; of this: https://github.com/purcell/exec-path-from-shell
(when (eq system-type 'darwin)
  (my-exec-path-from-shell-initialize))


;;; Modules

(mapc
 (lambda (path)
   (push (locate-user-emacs-file path) load-path))
 '("modules"))

(require 'init-no-littering)
(require 'init-package)
(require 'init-appearance)
(require 'init-essentials)
(require 'init-minibuffer)
(require 'init-search)
(require 'init-dired)
(require 'init-programming)
(require 'init-writing)
(require 'init-encryption)
(require 'init-llm)
