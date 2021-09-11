
%run guile

%var assoc-or

(define assoc-or
  (case-lambda
   ((key alist default)
    (let ((got (assoc key alist)))
      (if got (cdr got)
          default)))
   ((key alist)
    (let ((got (assoc key alist)))
      (and got (cdr got))))))
