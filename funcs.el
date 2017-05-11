
(defun reason/rtop-prompt ()
  "The rtop prompt function."
  (let ((prompt (format "rtop[%d]> " utop-command-number)))
    (add-text-properties 0 (length prompt) '(face utop-prompt) prompt)
    prompt))
