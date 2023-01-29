
%run guile

;; list-tag
%use (assert=) "./euphrates/assert-equal.scm"
%use (list-tag list-untag) "./euphrates/list-tag.scm"

(let ()
  (assert= '((2 (5 3 1) 7 9) (6 (9 7) 1 3))
           (list-tag even? '(1 3 5 2 7 9 6 1 3)))
  (assert= '(2 6)
           (map car (list-tag even? '(1 3 5 2 7 9 6 1 3))))

  (assert= '((2 (5 3 1) 7 9) (6 (9 7)))
           (list-tag even? '(1 3 5 2 7 9 6)))
  (assert= '(2 6)
           (map car (list-tag even? '(1 3 5 2 7 9 6))))

  (assert= '((4 () 1 3 5) (2 (5 3 1) 7 9) (6 (9 7) 1 3))
           (list-tag even? '(4 1 3 5 2 7 9 6 1 3)))
  (assert= '(4 2 6)
           (map car (list-tag even? '(4 1 3 5 2 7 9 6 1 3))))

  (assert= '((4 () 1 3 5) (2 (5 3 1) 7 9) (6 (9 7)))
           (list-tag even? '(4 1 3 5 2 7 9 6)))
  (assert= '(4 2 6)
           (map car (list-tag even? '(4 1 3 5 2 7 9 6))))

  (assert= #f
           (list-tag even? '()))

  (assert= #f
           (list-tag even? '(1 3 5 7)))

  (assert= '(1 3 5 2 7 9 6)
           (list-untag (list-tag even? '(1 3 5 2 7 9 6))))

  )
