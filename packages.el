;;; packages.el --- reason layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Fredrik Dyrkell
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst reason-packages
  '(company
    utop
    (reason-mode :location local)
    merlin))

(defun reason/post-init-company ()
  (spacemacs|add-company-hook merlin-mode))

(defun reason/init-reason-mode ()
  (use-package reason-mode
    :mode ("\\.re\\'" . reason-mode)
    :init
    (progn
      ;; (require 'utop)
      (add-hook 'reason-mode-hook (lambda ()
                                    (add-hook 'before-save-hook 'refmt-before-save)
                                    (merlin-mode)
                                    (utop-minor-mode)))
      (setq utop-command "opam config exec -- rtop -emacs")

      (evil-leader/set-key-for-mode 'reason-mode "<SPC>" 'company-complete)

      ;; (setq refmt-show-errors 'echo)
      (add-to-list 'display-buffer-alist
                   `(,(rx bos "*Refmt Errors*" eos)
                     (display-buffer-pop-up-window display-buffer-in-side-window)
                     (reusable-frames . visible)
                     (side            . bottom)
                     (window-height   . 0.15)))

      )))

(defun reason/post-init-merlin ()
  (use-package merlin
    :defer t
    :init
    (progn
      (setq merlin-completion-with-doc t)
      (setq merlin-ac-setup t)
      (push 'merlin-company-backend company-backends-merlin-mode)

      (spacemacs/set-leader-keys-for-major-mode 'reason-mode
        "cp" 'merlin-project-check
        "cv" 'merlin-goto-project-file
        "eC" 'merlin-error-check
        "en" 'merlin-error-next
        "eN" 'merlin-error-prev
        "gb" 'merlin-pop-stack
        "gg" 'merlin-locate
        "gG" 'spacemacs/merlin-locate-other-window
        "gl" 'merlin-locate-ident
        "gi" 'merlin-switch-to-ml
        "gI" 'merlin-switch-to-mli
        "go" 'merlin-occurrences
        "hh" 'merlin-document
        "ht" 'merlin-type-enclosing
        "hT" 'merlin-type-expr
        "rd" 'merlin-destruct)

      )))

;;; packages.el ends here
