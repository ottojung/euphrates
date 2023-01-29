
%run guile

;; list-take-while
%use (assert=) "./euphrates/assert-equal.scm"
%use (list-take-while) "./euphrates/list-take-while.scm"

(let ()
  (assert= '(2 4 6 8) (list-take-while even? '(2 4 6 8 9 3 1)))
  (assert= '() (list-take-while even? '(1 2 4 6 8 9 3 1)))
  (assert= '() (list-take-while even? '()))
  (assert= '(2 4 6 8) (list-take-while even? '(2 4 6 8)))
  )
