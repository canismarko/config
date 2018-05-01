;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; Mutt e-mail support
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

;; Remove menu bar and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Transparency for compositing window manager
(set-frame-parameter (selected-frame) 'alpha '(96 . 90))
(add-to-list 'default-frame-alist '(alpha . (96 . 90)))

;; For loading conda environments in pyvenv
;; (setenv "WORKON_HOME" "/home/mwolf/.conda/envs")
(setenv "WORKON_HOME" "/home/mwolf/miniconda3/envs")
(pyvenv-mode 1)

;; elpy
(elpy-enable)


;; Custom keyboard shortcuts
(global-set-key "\C-l" 'goto-line)
(global-set-key "\C-cr" 'recompile)
(global-set-key "\C-cm" 'compile)
(global-set-key "\C-c;" 'comment-or-uncomment-region)

;; Autoscroll to bottom of compilation window
(setq compilation-scroll-output 1)

;; Allow for varying buffer names
(require 'uniquify)

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
      '(("bib" . "~/Documents/literature/refs.bib::%s")
	("notes" . "~/Documents/literature/notes.org::#%s")
  	("papers" . "~/Documents/literature/papers/%s.pdf"))
      )
(eval-after-load "org"
  ;; Have PDF's open externally in okular
  '(progn
     ;; .txt files aren't in the list initially, but in case that changes
     ;; in a future version of org, use if to avoid errors
     ;; Change .pdf association directly within the alist
     (setcdr (assoc "\\.pdf\\'" org-file-apps) "okular %s")))
;; End of citation manager for org-mode

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (tango)))
 '(custom-safe-themes
   (quote
    ("715fdcd387af7e963abca6765bd7c2b37e76154e65401cd8d86104f22dd88404" default)))
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/Documents/literature/notes.org")))
 '(package-selected-packages (quote (scad-mode arduino-mode hamburg-theme jedi elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
