;;; edit-keybinds.el --- setup keybinds for emacs

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;; Setup xah-fly-keys, evil and Emacs original keybind.
;;

;;; Code:

(require 'init-funcs)

(unless (boundp 'flymacs-keybinding)
  (progn
    (setq flymacs-keybinding 'emacs)
    (message "Variable flymacs-keybinding is not set, use 'emacs as default.")))

(pcase flymacs-keybinding
  ('xah
   (use-package xah-fly-keys
     :load-path "site-lisp/"
     :demand
     :init (setq xah-fly-use-meta-key nil
                 xah-fly-use-control-key nil)
     :config
     ;; (eval-and-compile (require 'xah-fly-keys))
     (xah-fly-keys-set-layout "qwerty")
     (defun my-config-xah-fly-key-command ()
       "Modify keys for xah fly key command mode keys
to be added to `xah-fly-command-mode-activate-hook'"
       (interactive)
       (define-key xah-fly-key-map (kbd "n") 'swiper)
       (define-key xah-fly-key-map (kbd "2") 'delete-window)
       ;; more here
       )

     (defun my-config-xah-fly-key-insert ()
       "Modify keys for xah fly key command mode keys
to be added to `xah-fly-insert-mode-activate-hook'"
       (interactive)
       (define-key xah-fly-key-map (kbd "M-<SPC>") 'xah-fly-command-mode-activate)
       ;; more here
       )

     (add-hook 'xah-fly-command-mode-activate-hook 'my-config-xah-fly-key-command)
     (add-hook 'xah-fly-insert-mode-activate-hook 'my-config-xah-fly-key-insert)

     (xah-fly-keys 1)
     )
   )
  ('evil
   (use-package evil
     :config
     (setq evil-want-keybinding nil)
     (evil-mode 1)
     (use-package evil-collection
       :config
       (evil-collection-init))
     (use-package evil-surround
       :config
       (global-evil-surround-mode 1)))
   )
  ('emacs
   (message "Using default keybinding."))
  )

;;; edit-keybinds.el ends here


