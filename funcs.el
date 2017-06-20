(defun reason/rtop-prompt ()
  "The rtop prompt function."
  (let ((prompt (format "rtop[%d]> " utop-command-number)))
    (add-text-properties 0 (length prompt) '(face utop-prompt) prompt)
    prompt))

(defun reason/refmt-before-save ()
  "Before save hook for automatic refmt."
  (when reason-auto-refmt
      (refmt)))
