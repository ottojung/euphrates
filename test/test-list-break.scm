
%run guile

;; list-break
%use (assert=) "./src/assert-equal.scm"
%use (list-break) "./src/list-break.scm"

(let ()
  (define-values (a1 a2)
    (list-break even? '(3 5 7 2 1 9)))

  (assert= a1 '(3 5 7))
  (assert= a2 '(2 1 9)))
