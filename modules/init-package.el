;; -*- lexical-binding: t; -*-


;;;; Packages
;;;; ---------------------------------------------------------------------------

(use-package package
  :ensure nil
  :config
  (setq package-archives
        '(("gnu" . "https://elpa.gnu.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
          ("melpa" . "https://melpa.org/packages/")))
  ;; Higher number means higher priority. Default is 0.
  (setq package-archive-priorities
        '(("gnu" . 3)
          ("nongnu" . 2)
          ("melpa" . 1)))

  (package-initialize))

;;;; ---------------------------------------------------------------------------

(provide 'init-package)
