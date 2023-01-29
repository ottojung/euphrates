
%run guile

;; list-chunks
%use (assert=) "./euphrates/assert-equal.scm"
%use (list-chunks) "./euphrates/list-chunks.scm"

(let ()

  (assert=
   '((1 2) (3 4) (5 6))
   (list-chunks 2 '(1 2 3 4 5 6)))

  (assert=
   '((1) (2) (3) (4) (5) (6))
   (list-chunks 1 '(1 2 3 4 5 6)))

  (assert=
   '()
   (list-chunks 2 '()))

  (assert=
   '((1 2 3) (4 5 6) (7 8))
   (list-chunks 3 '(1 2 3 4 5 6 7 8)))

  )
