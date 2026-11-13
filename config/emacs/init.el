;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Written for Emacs 31 running in a terminal (Homebrew `emacs').
;; Uses the built-in use-package.  Third-party packages come from GNU ELPA
;; and MELPA and are installed on first start.

;;; Code:

;;;; Packages

(require 'package)
(setopt package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                           ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                           ("melpa" . "https://melpa.org/packages/")))
(require 'use-package)

;;;; Basics

(use-package emacs
  :custom
  (user-full-name "Shun Makino")
  (create-lockfiles nil)
  (tab-width 4)
  (indent-tabs-mode nil)
  (truncate-lines t)
  (use-short-answers t)
  (enable-recursive-minibuffers t)
  (history-length 1000)
  (history-delete-duplicates t)
  (case-fold-search t)
  (ring-bell-function #'ignore)
  (text-quoting-style 'straight)
  (use-dialog-box nil)
  (use-file-dialog nil)
  (scroll-preserve-screen-position t)
  (scroll-conservatively 100)
  (mouse-wheel-scroll-amount '(1 ((control) . 5)))
  (mouse-wheel-progressive-speed nil)
  (kill-ring-max 100)
  (kill-read-only-ok t)
  (kill-whole-line t)
  (eval-expression-print-length nil)
  (eval-expression-print-level nil)
  :bind
  (("M-ESC ESC" . redraw-frame))
  :config
  ;; C-h deletes backward, as in the shell.  Help is still on F1.
  (define-key key-translation-map (kbd "C-h") (kbd "DEL"))
  (menu-bar-mode 1)
  (global-display-line-numbers-mode 1)
  (load-theme 'manoj-dark t))

(use-package cus-edit
  :custom
  (custom-file (locate-user-emacs-file "custom.el"))
  :config
  (load custom-file 'noerror 'nomessage))

;;;; Files, auto-save and history

(use-package files
  :custom
  ;; No backup files (foo~).  Auto-save files go to backup/ instead of next to the file.
  (make-backup-files nil)
  (auto-save-timeout 15)
  (auto-save-interval 60)
  (auto-save-file-name-transforms
   `((".*" ,(locate-user-emacs-file "backup/") t)))
  (auto-save-list-file-prefix (locate-user-emacs-file "backup/.saves-")))

(use-package autorevert
  :custom (auto-revert-interval 1)
  :config (global-auto-revert-mode 1))

(use-package recentf
  :custom (recentf-max-saved-items 200)
  :config (recentf-mode 1))

(use-package savehist
  :config (savehist-mode 1))

(use-package saveplace
  :config (save-place-mode 1))

;;;; Editing

(use-package delsel
  :config (delete-selection-mode 1))

(use-package paren
  :custom (show-paren-delay 0.1))

(use-package editorconfig
  :config (editorconfig-mode 1))

(use-package mwim
  :ensure t
  :bind (("C-a" . mwim-beginning-of-code-or-line)
         ("C-e" . mwim-end-of-code-or-line)))

(use-package which-key
  :config (which-key-mode 1))

;;;; Terminal

;; The Homebrew build has no GUI.  Make the terminal frame behave.
(unless (display-graphic-p)
  ;; Mouse clicks and the wheel (needs the terminal to report mouse events).
  (xterm-mouse-mode 1)
  ;; Share the kill ring with the macOS clipboard.
  (when (and (eq system-type 'darwin) (executable-find "pbcopy"))
    (setq interprogram-cut-function
          (lambda (text)
            (let ((process-connection-type nil))
              (let ((proc (start-process "pbcopy" nil "pbcopy")))
                (process-send-string proc text)
                (process-send-eof proc)))))
    (setq interprogram-paste-function
          (lambda ()
            (let ((text (shell-command-to-string "pbpaste")))
              (unless (string-empty-p text) text))))))

;;;; Minibuffer completion

(use-package vertico
  :ensure t
  :custom (vertico-cycle t)
  :config (vertico-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :ensure t
  :config (marginalia-mode 1))

(use-package consult
  :ensure t
  :bind (("C-s" . consult-line)
         ("C-S-s" . consult-imenu)
         ("C-x b" . consult-buffer)
         ("C-x C-r" . consult-recent-file)
         ("M-y" . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-g f" . consult-flymake)
         ("M-s r" . consult-ripgrep)))

;;;; In-buffer completion

;; Emacs 31 supports child frames on text terminals, so corfu works in -nw.
(use-package corfu
  :ensure t
  :demand t                             ; :bind would otherwise defer :config
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.05)
  (corfu-auto-prefix 1)
  (corfu-count 12)
  (corfu-cycle t)
  :bind (:map corfu-map
              ("C-s" . corfu-insert-separator)
              ("C-i" . corfu-complete))
  :config (global-corfu-mode 1))

;;;; Programming

(use-package flymake
  :hook (prog-mode . flymake-mode)
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)))

(defvar my/language-servers
  '(((c-mode c++-mode c-ts-base-mode) clangd)
    ((python-base-mode) ruff basedpyright-langserver pyright-langserver pylsp))
  "Major modes and the language server executables eglot can use for them.")

(defun my/eglot-ensure-if-server ()
  "Start eglot when a language server for this major mode is installed."
  (when (seq-some (lambda (entry)
                    (and (derived-mode-p (car entry))
                         (seq-some (lambda (exe) (executable-find (symbol-name exe)))
                                   (cdr entry))))
                  my/language-servers)
    (eglot-ensure)))

(use-package eglot
  :hook ((c-mode c-ts-mode c++-mode c++-ts-mode python-mode python-ts-mode)
         . my/eglot-ensure-if-server))

;; Tree-sitter grammars.  Install with M-x my/treesit-install-grammars;
;; until then the classic modes are used.
(use-package treesit
  :preface
  (setq treesit-language-source-alist
        '((c "https://github.com/tree-sitter/tree-sitter-c")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (python "https://github.com/tree-sitter/tree-sitter-python")))
  (defun my/treesit-install-grammars ()
    "Install the tree-sitter grammars listed in `treesit-language-source-alist'."
    (interactive)
    (dolist (lang (mapcar #'car treesit-language-source-alist))
      (unless (treesit-language-available-p lang)
        (treesit-install-language-grammar lang))))
  :config
  (dolist (pair '((c . (c-mode . c-ts-mode))
                  (cpp . (c++-mode . c++-ts-mode))
                  (python . (python-mode . python-ts-mode))))
    (when (treesit-language-available-p (car pair))
      (add-to-list 'major-mode-remap-alist (cdr pair)))))

(use-package cc-mode
  :custom
  (c-default-style '((java-mode . "java") (awk-mode . "awk") (other . "bsd")))
  (c-basic-offset 4)
  :bind (:map c-mode-base-map ("C-c c" . compile)))

(use-package c-ts-mode
  :custom
  (c-ts-mode-indent-style 'bsd)
  (c-ts-mode-indent-offset 4)
  :bind (:map c-ts-base-mode-map ("C-c c" . compile)))

;;; init.el ends here
