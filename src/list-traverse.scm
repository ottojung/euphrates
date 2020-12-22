
%run guile

%var list-traverse

(define list-traverse
  (case-lambda
   ((lst chooser)
    (list-traverse lst #f chooser))
   ((lst default chooser)
    (let lp ((rest lst))
      (if (null? rest) default
          (let* ((head (car rest))
                 (tail (cdr rest)))
            (define-values (continue? return) (chooser head tail))
            (if continue?
                (lp return)
                return)))))))
