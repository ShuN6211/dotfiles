;;; early-init.el --- Settings that must run before the first frame -*- lexical-binding: t; -*-

;;; Commentary:
;; Loaded before package.el and the first frame.  Keep it to startup speed
;; and frame appearance; everything else lives in init.el.

;;; Code:

;; Collect garbage less often during startup, then go back to a sane value.
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

;; No tool bar or scroll bars (no-ops in a terminal, but keep GUI frames clean).
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq inhibit-startup-screen t
      frame-resize-pixelwise t)

;;; early-init.el ends here
