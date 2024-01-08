;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Giovanni Cemin"
      user-mail-address "guatariei@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
; (setq doom-font (font-spec :family "monospace" :size 15)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13)
;;       doom-big-font (font-spec :family "monospace" :size 24))
(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 17)
      ;;doom-unicode-font (font-spec :family "JuliaMono")
      ;;doom-serif-font (font-spec :family "IBM Plex Mono" :size 14 :weight 'light)
)
;;(setq doom-font (font-spec :family "monospace" :size 15 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "sans" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; Dark Theme:
;; (setq doom-theme 'doom-tomorrow-night)
;; (setq doom-theme 'doom-old-hope)
(setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-1337)
;; Light Theme:
;;(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 't) ; alternative t

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; no need for the following since it is the default dir I use
;;(after! conda
;;  (setq conda-env-home-directory (expand-file-name "~/anaconda3")))
;; Changig the workon dir of pyvenv in order to use anaconda envs
;;(setenv "WORKON_HOME" "~/anaconda3/envs")
;;(pyvenv-mode 1)
;;

;; BLACK
;; (use-package! python-black
;;   :demand t
;;   :after python
;;   :config
;;   (add-hook! 'python-mode-hook #'python-black-on-save-mode))
(use-package! blacken
  :demand t
  :after python
  :config
  (setq blacken-line-length 79)
  (add-hook! 'python-mode-hook 'blacken-mode))


;; ORG-MODE
;; in the init file I have also enabled org-journal, org-superstar
;; and org-roam by adding (+journal +pretty +roam2)
(after! org
  (setq org-directory "~/Documents/org/" ; default dir for new org files
        org-ellipsis " ▾" ; drop down character
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-hide-emphasis-markers t
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"             ; A task that is ready to be tackled
           "IN-PROGRESS"      ; A started task
           "STUDY(s)"            ; Things to study
           "LECT(l)"             ; Reorder lecture notes
           "PROJ(p)"             ; A project that contains other tasks
           "WAIT(w)"             ; Something is holding up this task
           "|"                   ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"             ; Task has been completed
           "CANCELLED(c)" ))     ; Task has been cancelled
        ))

(defun dt/org-colors-doom-one ()
  "Enable Doom One colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 2.0 "#58cded" ultra-bold)
         (org-level-2 1.7 "#5bcf83" extra-bold)
         (org-level-3 1.5 "#F4D160" bold)
         (org-level-4 1.4 "#FBEEAC" semi-bold)
         (org-level-5 1.3 "#5699af" normal)
         (org-level-6 1.2 "#a9a1e1" normal)
         (org-level-7 1.1 "#46d9ff" normal)
         (org-level-8 1.0 "#ff6c6b" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
  (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(with-eval-after-load 'org-faces
  ;; Load our desired dt/org-colors-* theme on startup
  (dt/org-colors-doom-one)
  ;; setting the todo-keywords only faces
  (setq org-todo-keyword-faces
        '(sequnce
          ;;         (quote (("TODO" :foreground "cyan" :weight bold))))))
          ("TODO" . (:family "DejaVu Sans Mono" :foreground "#F4D160" :weight normal))
          ("IN-PROGRESS" . (:family "DejaVu Sans Mono" :foreground "#ffffff" :weight normal))
          ("STUDY" . (:family "DejaVu Sans Mono" :foreground "#6aebf9" :weight normal))
          ("LECT" . (:family "DejaVu Sans Mono" :foreground "#ae81ff" :weight normal))
          ("PROJ" . (:family "DejaVu Sans Mono" :foreground "#e5141e" :weight normal))
          ("WAIT" . (:family "DejaVu Sans Mono" :foreground "#ae81ff" :weight normal))
          ))
  ;; (setq org-todo-keyword-faces
  ;;       '(("TODO" . org-warning) ("STARTED" . "yellow")
  ;;         ("CANCELED" . (:foreground "blue" :weight bold))))
  )



;; (use-package org-bullets
;;   :after org
;;   :hook (org-mode . org-bullets-mode)
;;   :custom (org-bullets-bullet-list '("⦿" "○" "●" "◦" "•")))

;; (dolist (face '((org-level-1 . 2.0)
;;                 (org-level-2 . 1.5)
;;                 (org-level-3 . 1.3)
;;                 (org-level-4 . 1.2)
;;                 (org-level-5 . 1.1)
;;                 (org-level-6 . 1.1)
;;                 (org-level-7 . 1.1)
;;                 (org-level-8 . 1.1)))
;;   (set-face-attribute (car face) nil :font "Cantarell" :weight 'bold :height (cdr face))
;;   )
;; ;; Ensure that anything that should be fixed-pitch in ORg files appears that way
;; (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
;; ;; (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;; replace dot in todo list
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
                                        ;(use-package org-bullets
                                        ;  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-emphasis-alist
      '(("*" (bold :foreground "white" :background "grey23"))
        ("/" italic)
        ("_" underline)
        ("=" (bold underline :foreground "OrangeRed"))
        ;;("~" (:foreground "black" :background "gold1"))
        ("~" (bold underline :foreground "gold1"))
        ("+" (:strike-through t))))
                                        ;(add-to-list 'org-emphasis-alist
                                        ;             '("*" (:foreground "white"
                                        ;                    :family "Anonymous Pro, Bold")))

;;(after! org
;;  (setq org-roam-directory "~/Documents/note/"))
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Documents/second_brain/note/")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n r" . org-roam-node-random)
         :map org-mode-map
         ("C-c n t" . org-roam-tag-add)
         ("C-c n a" . org-roam-alias-add)
         ("C-M-i" . completion-at-point)))
;;  :hook (after-init . org-roam-db-autosync-enable))

(after! org
  (setq org-agenda-files '("~/Documents/second_brain/agenda.org")))

(setq
 ;; org-fancy-priorities-list '("", "", "")
 org-fancy-priorities-list '("🟥", "🟧", "🟨")
 org-priority-faces
 '((?A :foreground "#c60004" :weight bold)
   (?B :foreground "#e95d00" :weight bold)
   (?C :foreground "#fadf00" :weight bold))
 org-agenda-block-separator 8411)

(setq
 org-agenda-custom-commands
 '(("v" "A better agenda view"
    ((tags "PRIORITY=\"A\""
           ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
            (org-agenda-overriding-header "High-priority unfinished tasks:")))
     (tags "PRIORITY=\"B\""
           ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
            (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
     (tags "PRIORITY=\"C\""
           ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
            (org-agenda-overriding-header "Low-priority unfinished tasks:")))
     (agenda "")
     (alltodo "")))))

;; ------ org-refs ----------
;; https://daryl.wakatara.com/zotero-and-org-roam-academic-research-workflow/
(use-package! org-ref
  :config
  (setq bibtex-completion-bibliography '("~/Documents/second_brain/refs/biblio.bib")
        bibtex-completion-notes-path "~/Documents/second_brain/refs/"
        bibtex-completion-pdf-field "file"
        bibtex-completion-pdf-open-function
        (lambda (fpath)
          (call-process "open" nil 0 nil fpath))))

(use-package! ivy-bibtex
  :after org-ref)

(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref)
  )

(use-package! org-ref-prettify
  :after org-ref
  (add-hook 'org-mode-hook 'org-ref-prettify-mode))

(use-package org-journal
  :ensure t
  :defer t
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  ;; (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir "~/Documents/second_brain/journal/"
        org-journal-date-prefix "#+TITLE: Daily Journal\n\n* "
        org-journal-file-format "%d-%M-%Y"
        org-journal-date-format "%A, %d %B %Y"
        ))

;; ------ org-roam-ui -------
;; https://github.com/org-roam/org-roam-ui
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; custom faces
(custom-set-faces!
  '(la-mia-face :slant italic))

;; custom eshell prompt
;;(setq eshell-prompt-function #'eshell-p10k-prompt-function
;;       eshell-prompt-regexp eshell-p10k-prompt-string)

;; ----- guess-language------
;; (use-package! guess-language         ; Automatically detect language for Flyspell
;;   ;;:after org
;;   ;;  :ensure t
;;   :defer t
;;   :init (add-hook 'text-mode-hook #'guess-language-mode)
;;   ;; :hook (org-mode . guess-language-mode) ; do not want to start automatically
;;   :config
;;   (setq guess-language-langcodes '((en . ("english" "English" "🇬🇧" "English"))
;;                                    (it . ("it" "Italiano" "🇮🇹" "Italiano")))
;;         guess-language-languages '(en it)
;;         guess-language-min-paragraph-length 45))
;;:diminish guess-language-mode)

;; ------ KEYBINDINGS ------
;; New keybindings by me! Yuppi
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "g") 'neotree-refresh))
