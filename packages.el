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
    (reason-mode :location local)
    merlin))

(defun reason/post-init-company ()
  (spacemacs|add-company-hook merlin-mode))

(defun reason/init-reason-mode ()
  (use-package reason-mode
    :mode ("\\.re\\'" . reason-mode)
    :config
    (progn
      (add-hook 'reason-mode-hook 'merlin-mode)
      )))

(defun reason/post-init-merlin ()
  (use-package merlin
    :defer t
    :init
    (progn
      (setq merlin-completion-with-doc t)
      (setq merlin-ac-setup t)
      (push 'merlin-company-backend company-backends-merlin-mode)
      )))

;;; packages.el ends here
