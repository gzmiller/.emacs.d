;;; -*- lexical-binding: t; -*-
(use-package doom-themes
  :custom-face
  (doom-modeline-buffer-file ((t (:inherit (mode-line bold)))))
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs usersXb
  (setq doom-themes-treemacs-theme "doom-colors")
  (with-eval-after-load 'lsp-treemacs
    (doom-themes-treemacs-config))
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )

(unless (boundp 'flymacs-theme-auto)
  (setq flymacs-theme-auto '(("7:00" . doom-one-light)
                             ("17:30" . doom-vibrant))))

(if (listp flymacs-theme-auto)
    (progn
      (use-package circadian
        :hook ('after-make-frame-functions . (lambda ()
                                               (circadian-setup)))
        :config
          (setq circadian-themes flymacs-theme-auto))
      (circadian-setup))
  (load-theme flymacs-theme-auto))

