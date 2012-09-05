(add-to-list 'load-path "~/.emacs.d")
(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))

;; Rectangular-mark
(require 'rect-mark)
(global-set-key (kbd "C-x r C-SPC") 'rm-set-mark)
(global-set-key (kbd "C-x r C-x")   'rm-exchange-point-and-mark)
(global-set-key (kbd "C-x r C-w")   'rm-kill-region)
(global-set-key (kbd "C-x r M-w")   'rm-kill-ring-save)

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(setq auto-mode-alist
      (cons '("\\.text" . markdown-mode) auto-mode-alist))

;; Highlight mode
(global-set-key (kbd "C-*") 'highlight-symbol-next)
(global-set-key (kbd "C-x *") 'highlight-symbol-prev)

;; Which-function mode
(set 'which-function-mode t)

;; Coffee mode
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)

(defun coffee-custom-hook ()
  "coffee-mode-hook"

  ;; CoffeeScript uses two spaces.
  (make-local-variable 'tab-width)
  (set 'tab-width 2)

  ;; If you don't want your compiled files to be wrapped
  (setq coffee-args-compile '("-c" "--bare"))

  ;; Emacs key binding
  (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)

  ;; Riding edge.
  ;; (setq coffee-command "~/dev/coffee")

  ;; Compile '.coffee' files on every save
  (and (file-exists-p (buffer-file-name))
       (file-exists-p (coffee-compiled-file-name))
       (coffee-cos-mode t)))

(add-hook 'coffee-mode-hook 'coffee-custom-hook)

;; Python mode
(require 'python)

(require 'arduino-mode)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'control)
;(global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages
  ;; starter-kit
  '(starter-kit starter-kit-lisp starter-kit-bindings
  ;; general
  color-theme color-theme-solarized undo-tree rect-mark slime slime-repl paredit magit idle-highlight-mode find-file-in-project
  ;; clojure
  clojure-mode
  ;; python
  markdown-mode
  highlight-mode
  ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; erlang mode setup
;;(setq load-path (cons "~/dev/otp_src_R14B03/lib/tools/emacs" load-path))
;;(setq erlang-root-dir "~/dev/otp_src_R14B03/")
;;(setq exec-path (cons "~/dev/otp_src_R14B03/bin" exec-path))
;; disable electric commands
;;(setq erlang-electric-commands '())
;;(add-hook 'erlang-mode-hook (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
;;(require 'erlang-start)

;; synchronizes emacs and osx's clipboards
(defun swap-and-kill ()
  "Swap point and mark, then clipboard kill region"
  (interactive)
  (exchange-point-and-mark)
  (clipboard-kill-region (region-beginning) (region-end))
  (deactivate-mark))

(global-set-key "\C-w" 'swap-and-kill)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)

(global-set-key (kbd "C-S-f") 'aquamacs-toggle-full-frame)

;; octave mode support
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; c/c++
(add-hook 'c++-mode-hook (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'c-mode-hook (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))

;; haskell mode setup
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; ===== Set the highlight current line minor mode =====
;; In every buffer, the line which contains the cursor will be fully
;; highlighted
(global-hl-line-mode 1)


;; ========== Line by line scrolling ==========
;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in
;; the center of the screen, but this can make the scrolling confusing
(setq scroll-step 1)


;; ========== Support Wheel Mouse Scrolling ==========
(mouse-wheel-mode t)


;; ========== Place Backup Files in Specific Directory ==========
;; Enable backup files.
(setq make-backup-files t)

;; Enable versioning with default values (keep five last versions, I think!)
(setq version-control t)

;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;; ========== Enable Line and Column Numbering ==========
;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)


;; ===== Make Text mode the default mode for new buffers =====
(setq default-major-mode 'text-mode)


(require 'linum)
(global-linum-mode 1)

(set-default-font "Menlo-12")

;; set tabs to spaces
(setq indent-tabs-mode nil)


(add-hook 'python-mode-hook (lambda () (idle-highlight-mode t)))

;; paredit
(add-to-list 'load-path "~/.emacs.d/paredit")
(require 'paredit)
(autoload 'paredit-mode "paredit"
      "Minor mode for pseudo-structurally editing Lisp code." t)
    (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
    (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
    (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
    (add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
    (add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))

;; this is making my aquaemacs slow - high cpu usage
;; rainbow-delimiters
;; (require 'rainbow-delimiters)
;; (global-rainbow-delimiters-mode)

;; slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))
	(defun paredit-mode-enable () (paredit-mode 1))
	(add-hook 'slime-mode-hook 'paredit-mode-enable)
	(add-hook 'slime-repl-mode-hook 'paredit-mode-enable)
	(setq slime-protocol-version 'ignore)))

;; slime
;;(eval-after-load "slime"
;;  '(progn (slime-setup '(slime-repl))))


(add-to-list 'load-path "~/.emacs.d/clojure/slime")
(require 'slime)
(setq slime-use-autodoc-mode nil)
(slime-setup)

;; show trailing whitespace
(setq-default show-trailing-whitespace 't)

;; key bindings
(global-set-key (kbd "C-x C-;") 'comment-region)

;; enable undo-tree mode
(require 'undo-tree)
(global-undo-tree-mode)

(require 'color-theme)
;; solarized color theme
(require 'color-theme-solarized)

(color-theme-solarized-dark)

(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

(setenv "PATH"
  (concat
   "/usr/local/share/python:"
   (getenv "PATH")))

(setq exec-path '("/usr/local/share/python"))

;; use codequality for type and style checking
(when (load "flymake" t)
  (defun flymake-codequality-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "codequality" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
           '("\\.py\\'" flymake-codequality-init))
  (add-to-list 'flymake-allowed-file-name-masks
           '("\\.js\\'" flymake-codequality-init))
  (add-hook 'find-file-hook 'flymake-find-file-hook))


;;; flymake-cursor.el --- displays flymake error msg in minibuffer after delay
;;
;; Author     : ??
;; origin     : http://paste.lisp.org/display/60617,1/raw
;; Maintainer : Dino Chiesa <dpchiesa@hotmail.com>
;; Created    : May 2011
;; Modified   : May 2011
;; Version    : 0.1.1
;; Keywords   : languages mode flymake
;; X-URL      : http://www.emacswiki.org/emacs/flymake-cursor.el
;; Last-saved : <2011-May-09 16:35:59>
;;
;; -------------------------------------------------------
;;
;; License: None.  This code is in the Public Domain.
;;
;;
;; Additional functionality that makes flymake error messages appear
;; in the minibuffer when point is on a line containing a flymake
;; error. This saves having to mouse over the error, which is a
;; keyboard user's annoyance.
;;
;; -------------------------------------------------------
;;
;; This flymake-cursor module displays the flymake error in the
;; minibuffer, after a short delay.  It is based on code I found roaming
;; around on the net, unsigned and unattributed. I suppose it's public
;; domain, because, while there is a "License" listed in it, there
;; is no license holder, no one to own the license.
;;
;; This version is modified slightly from that code. The post-command fn
;; defined in this code does not display the message directly. Instead
;; it sets a timer, and when the timer fires, the timer event function
;; displays the message.
;;
;; The reason to do this: the error message is displayed only if the
;; user doesn't do anything, for about one second. This way, if the user
;; scrolls through a buffer and there are myriad errors, the minibuffer
;; is not constantly being updated.
;;
;; If the user moves away from the line with the flymake error message
;; before the timer expires, then no error is displayed in the minibuffer.
;;
;; I've also updated the names of the defuns. They all start with flyc now.
;;
;; To use this, include this line in your .emacs:
;;
;;    ;; enhancements for displaying flymake errors
;;    (require 'flymake-cursor)
;;
;; You can, of course, put that in an eval-after-load clause.
;;

(require 'cl)

(defvar flyc--e-at-point nil
  "Error at point, after last command")

(defvar flyc--e-display-timer nil
  "A timer; when it fires, it displays the stored error message.")

(defun flyc/maybe-fixup-message (errore)
  "pyflake is flakey if it has compile problems, this adjusts the
message to display, so there is one ;)"
  (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t)))
        ((null (flymake-ler-file errore))
         ;; normal message do your thing
         (flymake-ler-text errore))
        (t ;; could not compile error
         (format "compile error, problem on line %s" (flymake-ler-line errore)))))


(defun flyc/show-stored-error-now ()
  "Displays the stored error in the minibuffer."
  (interactive)
  (if flyc--e-at-point
      (progn
        (message "%s" (flyc/maybe-fixup-message flyc--e-at-point))
        (setq flyc--e-display-timer nil))))


(defun flyc/-get-error-at-point ()
  "Gets the first flymake error on the line at point."
  (let ((line-no (line-number-at-pos))
        flyc-e)
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
          (setq flyc-e (car (second elem)))))
    flyc-e))


(defun flyc/show-fly-error-at-point-now ()
  "If the cursor is sitting on a flymake error, display
the error message in the  minibuffer."
  (interactive)
  (if flyc--e-display-timer
      (progn
        (cancel-timer flyc--e-display-timer)
        (setq flyc--e-display-timer nil)))
  (let ((error-at-point (flyc/-get-error-at-point)))
    (if error-at-point
        (progn
          (setq flyc--e-at-point error-at-point)
          (flyc/show-stored-error-now)))))



(defun flyc/show-fly-error-at-point-pretty-soon ()
  "If the cursor is sitting on a flymake error, grab the error,
and set a timer for \"pretty soon\". When the timer fires, the error
message will be displayed in the minibuffer.

This allows a post-command-hook to NOT cause the minibuffer to be
updated 10,000 times as a user scrolls through a buffer
quickly. Only when the user pauses on a line for more than a
second, does the flymake error message (if any) get displayed.

"
  (if flyc--e-display-timer
      (cancel-timer flyc--e-display-timer))

  (let ((error-at-point (flyc/-get-error-at-point)))
    (if error-at-point
        (setq flyc--e-at-point error-at-point
              flyc--e-display-timer
              (run-at-time "0.9 sec" nil 'flyc/show-stored-error-now))
      (setq flyc--e-at-point nil
            flyc--e-display-timer nil))))



(eval-after-load "flymake"
  '(progn

     (defadvice flymake-goto-next-error (after flyc/display-message-1 activate compile)
       "Display the error in the mini-buffer rather than having to mouse over it"
       (flyc/show-fly-error-at-point-now))

     (defadvice flymake-goto-prev-error (after flyc/display-message-2 activate compile)
       "Display the error in the mini-buffer rather than having to mouse over it"
       (flyc/show-fly-error-at-point-now))

     (defadvice flymake-mode (before flyc/post-command-fn activate compile)
       "Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
displayed in the minibuffer (rather than having to mouse over
it)"
       (set (make-local-variable 'post-command-hook)
            (cons 'flyc/show-fly-error-at-point-pretty-soon post-command-hook)))))


(provide 'flymake-cursor)
