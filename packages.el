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
    (merlin :location (recipe :fetcher github :repo "ocaml/merlin" :commit "v2.5.4" :files ("emacs/*.el")))
    ;;merlin
    popwin))

(defun reason/post-init-company ()
  (when (configuration-layer/package-usedp 'merlin)
    (spacemacs|add-company-backends
      :backends merlin-company-backend
      :modes reason-mode))
  )

(defun reason/init-reason-mode ()
  (use-package reason-mode
    :defer t
    :mode ("\\.rei?\\'" . reason-mode)
    :init
    (progn
      (add-hook 'reason-mode-hook (lambda ()
                                    (add-hook 'before-save-hook 'reason/refmt-before-save nil t)))
      (add-hook 'reason-mode-hook 'merlin-mode)
      (add-hook 'reason-mode-hook 'utop-minor-mode)

      (spacemacs|add-toggle reason-auto-refmt
        :documentation "Toggle automatic refmt on save."
        :status reason-auto-refmt
        :on (setq reason-auto-refmt t)
        :off (setq reason-auto-refmt nil))
      )
    :config
    (progn
      (spacemacs/declare-prefix-for-mode 'reason-mode "mc" "compile")
      (spacemacs/declare-prefix-for-mode 'reason-mode "mt" "toggle")
      (spacemacs/declare-prefix-for-mode 'reason-mode "me" "errors/eval")
      (spacemacs/declare-prefix-for-mode 'reason-mode "mg" "goto")
      (spacemacs/declare-prefix-for-mode 'reason-mode "mh" "help/show")
      (spacemacs/declare-prefix-for-mode 'reason-mode "mr" "refactor")
      (spacemacs/declare-prefix-for-mode 'reason-mode "m=" "refmt")

      (spacemacs/set-leader-keys-for-major-mode 'reason-mode
        "cr" 'refmt
        "==" 'refmt
        "tr" 'spacemacs/toggle-reason-auto-refmt)
      )
    ))

(defun reason/pre-init-popwin ()
  (spacemacs|use-package-add-hook popwin
    :post-config
    (push '("*Refmt Errors*" :tail t :position bottom :noselect t) popwin:special-display-config)))

(defun reason/pre-init-utop ()
  (spacemacs|use-package-add-hook utop
    :post-init
    (add-hook
     'reason-mode-hook
     (lambda ()
       (setq utop-command "rtop -emacs")
       (setq utop-edit-command nil)
       (setq utop-prompt 'reason/rtop-prompt)
       (setq utop-initial-command "let myVar = \"Hello Reason!\";")
       (setq utop-phrase-terminator ";")
       ))
    :post-config
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'reason-mode
        "er" 'utop-eval-region
        "eb" 'utop-eval-buffer
        "ee" 'utop-eval-phrase)
      )
    ))

(defun reason/post-init-merlin ()
  (use-package merlin
    :defer t
    :init
    (progn
      (setq merlin-completion-with-doc t)

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
