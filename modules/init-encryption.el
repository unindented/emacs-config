;; -*- lexical-binding: t; -*-


;;; Encryption

(use-package epa-file
  :ensure nil
  :custom
  ;; Provided by GPG Suite.
  (epg-gpg-program "/usr/local/bin/gpg"))

(use-package epg-config
  :ensure nil
  :config
  (setq epg-pinentry-mode 'loopback))


(provide 'init-encryption)
