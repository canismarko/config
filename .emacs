(setq load-path (cons (expand-file-name "~/.elisp") load-path))

;; Downloadable repositiories from MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Python autocompletion via jedi library
(elpy-enable)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq elpy-rpc-backend "jedi")

;; Goto line shortcut
(global-set-key "\C-l" 'goto-line)

;; Citation manager for org-mode
(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
	 ;enable auto-revert-mode to update reftex when bibtex file changes on disk
	 (global-auto-revert-mode t)
	 (reftex-parse-all)
	 ;add a custom reftex cite format to insert links
	 (reftex-set-cite-format
	  '((?b . "[[bib:%l][%l-bib]]")
	    (?n . "[[notes:%l][%l-notes]]")
	    (?p . "[[papers:%l][%l-paper]]")
	    (?t . "%t")
	    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)
(setq org-link-abbrev-alist
      '(("bib" . "~/research/refs.bib::%s")
	("notes" . "~/research/org/notes.org::#%s")
	("papers" . "~/Documents/literature/papers/%s.pdf")))
;; End of citation manager for org-mode

;; Git tracking
(define-key global-map "\C-cc" 'magit-status)

;; ;; Python mode maintained by core developers
;; (require 'python-mode)

;; Mark lines longer than 80
(require 'whitespace)
(setq whitespace-style '(face empty lines-tail trailing))
(global-whitespace-mode t)

;; pony-mode for django
;; (add-to-list 'load-path "/home/mwolf/src/pony-mode/src")
;; (require 'pony-mode)

;; Allow for varying buffer names
(require 'uniquify)
;; Version for arch linux (from AUR)
(require 'org-install)
;; The following lines are always needed. Choose your own keys
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cm" 'compile)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
;(global-font-lock-mode 1) ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)
(transient-mark-mode 1)
;; The screen program appropriates C-a so switching beggining of line to another key
(global-set-key "\C-r" 'beginning-of-line)
;; Org-mode global variables
(setq org-directory "~/org")
(setq org-capture-file (concat org-directory "/work.org"))
(setq org-mobile-inbox-for-pull org-capture-file)
(setq org-mobile-directory (concat org-directory "/mobile"))
(setq org-todo-keywords
      ;; Set specific TODO states for org-mode
      '((sequence "DFRD(f)" "NEXT(n)" "ACTN(a)" "|" "DONE(d)")
	(sequence "SMDY(s)" "|" "WAIT(w)" "CNCL(c)" )
	(sequence "HARD(h)" "|")))
(setq org-todo-keyword-faces
      '(("HARD" . (:foreground "magenta1" :weight bold)) ("WAIT" . (:foreground "#00C798" :weight bold))
	("CNCL" . (:foreground "blue")) ("ICBT". (:foreground "purple"))
	("ACTN" . (:foreground "white" :weight bold))
	("DONE" . (:foreground "#0A8C1D" :weight bold))
	("NEXT" . (:foreground "#F26161" :weight bold))
	("DFRD" . (:foreground "orange" :weight bold))
	("SMDY" . (:foreground "#85570D"))))
;; Workaround for gnome issue with M-Ret and C-Ret being mapped as C-(M-)j
(add-hook 'org-mode-hook
          (lambda ()
            (if window-system
                nil
              (progn
                (define-key org-mode-map "\C-\M-j" 'org-meta-return)
                (define-key org-mode-map "\C-j" 'org-insert-heading-respect-content)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-agenda-custom-commands (quote (("s" "Someday/Maybe List" todo "SMDY" ((org-agenda-overriding-header "Someday Maybe List")) ("/home/mark/org/mobile/someday.html")) ("d" "Deferred (Agenda)" agenda "" ((org-agenda-overriding-header "Upcoming Deferred Items for 1 Month") (org-agenda-span (quote month)) (org-agenda-skip-function (quote (org-agenda-skip-entry-if (quote nottodo) (quote ("DFRD")))))) ("/home/mark/org/mobile/deferred-agenda.html")) ("D" "Deferred (List)" todo "DFRD" ((org-agenda-overriding-header "Deferred Actions List")) ("/home/mark/org/mobile/deferred-list.html")) ("A" "Monthly Agenda" agenda "" ((org-agenda-overriding-header "Day-Specific and Deferred Actions") (org-agenda-span (quote month)) (org-agenda-skip-function (quote (org-agenda-skip-entry-if (quote nottodo) (quote ("HARD" "DFRD")))))) ("/home/mark/org/mobile/monthly-agenda.html")) ("a" "Daily Agenda" ((agenda "" ((org-agenda-overriding-header "Day-Specific and Deferred Actions") (org-agenda-span (quote day)) (org-agenda-skip-function (quote (org-agenda-skip-entry-if (quote nottodo) (quote ("HARD" "DFRD"))))))) (agenda "" ((org-agenda-overriding-header "Upcoming Deadlines") (org-agenda-start-on-weekday nil) (org-deadline-warning-days 0) (org-agenda-skip-function (quote (org-agenda-skip-entry-if (quote notdeadline))))))) nil ("/home/mark/org/mobile/daily-agenda.html")) ("w" "Waiting-For List" todo "WAIT" ((org-agenda-overriding-header "List of things awaiting ouside input")) ("waiting.html")) ("c" "List of All Actions (Should any be changed to NEXT?)" todo "ACTN" ((org-agenda-overriding-header "List of all actions (both next and further out)"))) ("n" . "Next Action List") ("nw" "Work" todo "NEXT" ((org-agenda-overriding-header "Next Action List for Work") (org-agenda-filter-preset (quote ("-home" "-car" "-barn")))) ("/home/mark/org/mobile/next-work.html")) ("nh" "Home" todo "NEXT" ((org-agenda-overriding-header "Next Action List for Home") (org-agenda-filter-preset (quote ("-work" "-car" "-barn")))) ("/home/mark/org/mobile/next-home.html")) ("nc" "Car" todo "NEXT" ((org-agenda-overriding-header "Next Action List while in the Car") (org-agenda-filter-preset (quote ("+car")))) ("/home/mark/org/mobile/next-car.html")) ("nb" "Barn" todo "NEXT" ((org-agenda-overriding-header "Next Action List while at artios Barn") (org-agenda-filter-preset (quote ("+barn")))) ("/home/mark/org/mobile/next-barn.html")) ("np" "Phone" todo "NEXT" ((org-agenda-overriding-header "Actions requiring a Telephone") (org-agenda-filter-preset (quote ("+phone")))) ("/home/mark/org/mobile/next-phone.html")) ("nl" "Computer" todo "NEXT" ((org-agenda-filter-preset (quote ("+comp")))) ("/home/mark/org/mobile/next-computer.html")) ("na" "All" todo "NEXT" ((org-agenda-overriding-header "All Next Action Items")) ("/home/mark/org/mobile/next-all.html")) ("p" . "Person Specific Items") ("pg" "George" tags "GK" ((org-agenda-overriding-header "Items Specific to George Kean"))) ("pj" "Jill" tags "JM" ((org-agenda-overriding-header "Items Specific to Jill McKeague"))) ("pd" "Doug" tags "DW" ((org-agenda-overriding-header "Items Specific to Doug Williams"))) ("pw" "John W." tags "JW" ((org-agenda-overriding-header "Items Specific to John Weaver"))) ("pp" "Polly" tags "PB" ((org-agenda-overriding-header "Items Specific to Polly Barret"))) ("pm" "Meghan" tags "MP" ((org-agenda-overriding-header "Items Specific to Meghan Peltz"))) ("pa" "Patti" tags "PR" ((org-agenda-overriding-header "Items Specific to Patti Robers"))) ("pr" "Roger" tags "RN" ((org-agenda-overriding-header "Items Specific to Roger Nahas"))))))
 '(org-agenda-files (quote ("~/Documents/jglcrm-2015/agenda" "~/src/orgwolf/project-overview.org")))
 '(org-agenda-sorting-strategy (quote ((agenda habit-down time-up priority-down category-keep) (todo category-keep priority-down) (tags priority-down category-keep) (search category-keep))))
 '(org-attach-method (quote ln))
 '(org-cycle-open-archived-trees t)
 '(org-file-apps (quote ((auto-mode . emacs) ("\\.mm\\'" . default) ("\\.x?html?\\'" . default) ("\\.od[tsp]\\'" . "libreoffice %s") ("\\.pdf\\'" . "okular %s"))))
 '(tex-run-command "pdflatex")
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-hide ((((background light)) (:foreground "black")))))
;; Save all org-mode files so they can be synced with git
;; uncomment for git (run-at-time "00:59" 3600 'org-save-all-org-buffers)

;; ;; Use a custom defined document class for LaTeX exporting
;; (require 'org-latex)
;; (unless (boundp 'org-export-latex-classes)
;;   (setq org-export-latex-classes nil))
;; (add-to-list 'org-export-latex-classes
;;              '("article"
;;                "\\documentclass{org-article}"
;;                ("\\section{%s}" . "\\section*{%s}")))  
;; Turn on logging for completion time of tasks
(setq org-log-done 'time)
;; Skip done entries in agendas
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
;; Run org-mobile-push upon save
;; (defun mobile-org-setup ()
;;  (add-hook 'after-save-hook 'org-mobile-push))
;; uncomment to turn on mobileOrg (add-hook 'org-mode-hook 'mobile-org-setup)
(setq org-mobile-force-id-on-agenda-items nil)
;; S-Left/S-Right cycle todo states w/out timestamping
(setq org-treat-S-cursor-todo-selection-as-state-change nil)
;; Capture mode setup
(setq org-default-notes-file org-capture-file)
;; I use C-c c to start capture mode
;; removed in favor of 'magic-status
;; (define-key global-map "\C-cc" 'org-capture)

;;--------------------------------------------------------------------
;; Lines enabling gnuplot-mode

;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))

;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode 
  (global-set-key [(f9)] 'gnuplot-make-buffer)

;; end of line for gnuplot-mode
;;--------------------------------------------------------------------

;;--------------------------------------------------------------------
;; Count words for current region
(autoload 'word-count-mode "word-count"
          "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)
;;--------------------------------------------------------------------
