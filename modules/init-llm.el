;; -*- lexical-binding: t; -*-


;;; LLM

(use-package gptel
  :ensure t
  :config
  ;; Set default model.
  (setq gptel-model 'deepseek-r1:14b
        gptel-backend (gptel-make-ollama "Ollama"
                        :host "localhost:11434"
                        :stream t
                        :models '(deepseek-r1:14b))))


(provide 'init-llm)
