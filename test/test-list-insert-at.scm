
%run guile

;; list-insert-at
%use (assert=) "./euphrates/assert-equal.scm"
%use (list-insert-at) "./euphrates/list-insert-at.scm"

(let ()
  (assert= '(a b c d)
           (list-insert-at '(a b d) 2 'c))

  (assert= '(a b c d)
           (list-insert-at '(b c d) 0 'a))

  (assert= '(a b c d)
           (list-insert-at '(a b c) 3 'd))

  (assert= '(a b c d)
           (list-insert-at '(a b c) 999999 'd))

  (assert= '(a b c d)
           (list-insert-at '(a b c) +inf.0 'd)))
