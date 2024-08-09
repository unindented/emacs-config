;; -*- lexical-binding: t; -*-


;;; Writing

(use-package emacs
  :ensure nil
  :config
  ;; Tab completion.
  (setq tab-always-indent 'complete
        tab-first-completion 'word-or-paren-or-punct)
  ;; Spaces over tabs.
  (setq-default c-basic-offset 2
                tab-width 2
                indent-tabs-mode nil))

(use-package org
  :ensure nil
  :config
  (setq org-directory (file-truename "~/org/"))
  ;; Always display inline images.
  (setq org-startup-with-inline-images t))

(use-package oc
  :ensure nil
  :config
  (setq org-cite-global-bibliography '("~/org/library.json")
        org-cite-csl-styles-dir "~/org/csl/"
        org-cite-export-processors '((html . (csl "ieee-with-url-modified.csl"))
                                     (md . (csl "ieee-with-url-modified.csl"))
                                     (t . (csl "modern-language-association.csl")))))

(use-package citeproc
  :ensure t)

(use-package ox-hugo
  :ensure t)

(use-package ox-huguito
  :vc ( :url "https://github.com/unindented/ox-huguito"
        :rev :newest)
  :ensure t)

(use-package denote
  :vc ( :url "https://github.com/protesilaos/denote"
        :rev :newest)
  :ensure t
  :hook
  (
   ;; Fontify links in Markdown and plain text files.
   (text-mode . denote-fontify-links-mode-maybe)
   ;; Highlight Denote file names in Dired buffers.
   (dired-mode . denote-dired-mode))
  :bind
  ( :map global-map
    ("C-c n n" . denote)
    ("C-c n N" . denote-type)
    ("C-c n o" . denote-sort-dired) ; "order" mnemonic
    ("C-c n r" . denote-rename-file)
    :map text-mode-map
    ("C-c n i" . denote-link) ; "insert" mnemonic
    ("C-c n I" . denote-add-links)
    ("C-c n b" . denote-backlinks)
    ("C-c n R" . denote-rename-file-using-front-matter)
    :map org-mode-map
    ("C-c n d l" . denote-org-extras-dblock-insert-links)
    ("C-c n d b" . denote-org-extras-dblock-insert-links)
    :map dired-mode-map
    ("C-c C-d C-i" . denote-link-dired-marked-notes)
    ("C-c C-d C-r" . denote-dired-rename-marked-files)
    ("C-c C-d C-k" . denote-dired-rename-marked-files-with-keywords)
    ("C-c C-d C-f" . denote-dired-rename-marked-files-using-front-matter))
  :config
  (setq denote-directory (expand-file-name "~/org/notes2/"))
  ;; Default to Org file.
  (setq denote-file-type 'org)
  ;; Customize keywords.
  (setq denote-known-keywords '("emacs" "vim")
        denote-infer-keywords t
        denote-sort-keywords t)
  ;; Automatically rename Denote buffers when opening them.
  (setq denote-rename-buffer-format "[D] %t %b")
  (denote-rename-buffer-mode 1))

(use-package outline
  :ensure nil
  :bind
  ( :map global-map
    ("<f9>" . outline-minor-mode))
  :config
  (setq outline-minor-mode-cycle t)
  (setq outline-minor-mode-highlight nil)
  (setq outline-minor-mode-use-buttons nil)
  (setq outline-minor-mode-use-margins nil))

(provide 'init-writing)
