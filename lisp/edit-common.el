(show-paren-mode t)
;; move window
(windmove-default-keybindings)
;; Overwrite region selected
(delete-selection-mode t)
;; Show column numbers by default
(setq column-number-mode t)
;; Use CUA to delete selections
(setq cua-mode t)
(setq cua-enable-cua-keys nil)
(setq auto-save-default nil)
;; Prevent emacs from creating a bckup file filename~
(setq make-backup-files nil)
;; Settings for searching
(setq-default case-fold-search t ;case insensitive searches by default
              search-highlight t) ;hilit matches when searching
;; Highlight the line we are currently on
(global-hl-line-mode -1)
;; Disable the toolbar at the top since it's useless
;; (if (functionp 'tool-bar-mode) (tool-bar-mode -1))
;; (tool-bar-mode 0)                     
;; (menu-bar-mode 0)
;; (when (display-graphic-p) (scroll-bar-mode 0))

(electric-pair-mode 1)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; Remove trailing white space upon saving
;; Note: because of a bug in EIN we only delete trailing whitespace
;; when not in EIN mode.
;; (add-hook 'before-save-hook
;;           (lambda ()
;;             (when (not (derived-mode-p 'ein:notebook-multilang-mode))
;;               (delete-trailing-whitespace))))

;; (global-auto-revert-mode 1)

;; Auto-wrap at 80 characters
(setq-default auto-fill-function 'do-auto-fill)
(setq-default fill-column 80)
(turn-on-auto-fill)
;; Disable auto-fill-mode in programming mode
(add-hook 'prog-mode-hook (lambda () (auto-fill-mode -1)))

;; Highlight some keywords in prog-mode
(add-hook 'prog-mode-hook
          (lambda ()
            ;; Highlighting in cmake-mode this way interferes with
            ;; cmake-font-lock, which is something I don't yet understand.
            (when (not (derived-mode-p 'cmake-mode))
              (font-lock-add-keywords
               nil
               '(("\\<\\(FIXME\\|TODO\\|BUG\\|DONE\\)"
                  1 font-lock-warning-face t))))
            )
          )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable terminal emacs to copy and paste from system clipboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun osx-copy (beg end)
  (interactive "r")
  (call-process-region beg end  "pbcopy"))

(defun osx-paste ()
  (interactive)
  (if (region-active-p) (delete-region (region-beginning) (region-end)) nil)
  (call-process "pbpaste" nil t nil))

(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-aBhl --group-directories-first"))

(global-set-key (kbd "C-c M-w") 'osx-copy)
(global-set-key (kbd "C-c C-y") 'osx-paste)

;; (use-package exec-path-from-shell)
;; (exec-path-from-shell-initialize)

(use-package anzu
  :diminish
  :bind (([remap query-replace] . anzu-query-replace)
         ([remap query-replace-regexp] . anzu-query-replace-regexp)
         :map isearch-mode-map
         ([remap isearch-query-replace] . anzu-isearch-query-replace)
         ([remap isearch-query-replace-regexp] . anzu-isearch-query-replace-regexp))
  :hook (after-init . global-anzu-mode))

(use-package multiple-cursors
  :defer 5
  :bind (("M-n" . mc/mark-next-like-this)
         ("M-p" . mc/mark-previous-like-this)
         ("C-c a" . mc/mark-all-like-this)
         ("C-c e" . mc/edit-lines))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; avy: always fast jump to char inside the current view buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package avy
  :defer 4
  :bind (("M-c" . avy-goto-char)
         ("M-s" . avy-goto-word-1))
  ;; Set keys for Dvorak mode instead of qwerty
  ;; :init (setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s
  ;;                           ?A ?O ?E ?U ?I ?D ?H ?T ?N ?S
  ;;                           ?p ?y ?f ?g ?c ?r ?l
  ;;                           ?P ?Y ?F ?G ?C ?R ?L))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; zzz-to-char: replaces the built-in zap-to-char with avy-like
;;              replacement options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package zzz-to-char
  :defer 4
  :bind ("M-z" . zzz-up-to-char))

                                        ; shortcuts

;; Global Keyboard Shortcuts
;; Set help to C-?
;; (global-set-key (kbd "C-c h") 'help-command)
;; (global-set-key (kbd "C-c h") help-map)
;; Set mark paragraph to M-?
;; (global-set-key (kbd "M-?") 'mark-paragraph)
;; Set backspace to C-h
;; (global-set-key (kbd "C-h") 'delete-backward-char)
;; Set backspace word to M-h
;; (global-set-key (kbd "M-h") 'backward-kill-word)
;; Use meta+tab word completion
;; (global-set-key (kbd "M-TAB") 'dabbrev-expand)
;; Easy undo key
(global-set-key (kbd "C-/") 'undo)
;; Comment or uncomment the region
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
;; Indent after a newline, if required by syntax of language
(global-set-key (kbd "C-m") 'newline-and-indent)
;; Load the compile ocmmand
(global-set-key (kbd "C-c C-c") 'compile)
;; Undo, basically C-x u
;; (global-set-key (kbd "C-/") 'undo)
;; Find file in project
(global-set-key (kbd "C-x M-f") 'project-find-file)
(global-set-key (kbd "C-r") 'replace-string)
;; Copy and paste
;; complete the code
;;(global-set-key (kbd "C-c TAB") 'company-complete)
