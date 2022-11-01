
%run guile

%use (assert=HS) "./src/assert-equal-hs.scm"
%use (list-group-by) "./src/list-group-by.scm"

(let () ;; list-group-by
  (assert=HS '((#t 4 2) (#f 5 3 1))
             (list-group-by even? '(1 2 3 4 5)))
  (assert=HS '((0 3) (1 4 1) (2 5 2))
             (list-group-by (lambda (x) (modulo x 3)) '(1 2 3 4 5)))
  )
