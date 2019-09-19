(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; Default setup for accessing remote file
(setq tramp-default-method "ssh")
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; Load spell check and grammar check
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(add-hook 'python-mode-hook
  (lambda ()
  (flyspell-prog-mode)
  ))

;; Tide setup for typescript IDE
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Auto-calculation of math formula
(defun calc-eval-region (arg beg end)
  "Calculate the region and display the result in the echo area.
With prefix ARG non-nil, insert the result at the end of region."
  (interactive "P\nr")
  (let* ((expr (buffer-substring-no-properties beg end))
         (result (calc-eval expr)))
        (message "%s = %s" expr result)
      (delete-region beg end)
      (save-excursion
        (insert result))))

(global-set-key (kbd "C-c c") 'calc-eval-region)

;; Mutt e-mail support
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

;; Remove menu bar and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Transparency for compositing window manager
(set-frame-parameter (selected-frame) 'alpha '(97 . 90))
(add-to-list 'default-frame-alist '(alpha . (97 . 90)))

;; Python IDE setup
(setenv "WORKON_HOME" "~/miniconda3/envs")
;; (pyvenv-workon "python3")
;; (pyvenv-activate "~/miniconda3")
(elpy-enable)
(require 'conda)
(conda-env-initialize-interactive-shells)
;; (add-hook 'python-mode-hook 'anaconda-mode)
(setq jedi:environment-root "~/miniconda3")
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("a7051d761a713aaf5b893c90eaba27463c791cd75d7257d3a8e66b0c8c346e77" "715fdcd387af7e963abca6765bd7c2b37e76154e65401cd8d86104f22dd88404" default)))
 '(inhibit-startup-screen t)
 '(load-home-init-file t t)
 '(org-agenda-files (quote ("~/Documents/literature/notes.org")))
 '(package-selected-packages
   (quote
    (zenburn-theme markdown-mode typescript-mode tide scad-mode arduino-mode hamburg-theme jedi elpy))))

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
	    (?h . "** %t\n   :PROPERTIES:\n   :Custom_ID: %l\n   :END:\n   [[papers:%l][%l-paper]]")))))
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
(global-set-key "\C-ca" 'org-agenda)
;; End of citation manager for org-mode


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
