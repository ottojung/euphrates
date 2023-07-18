
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-insert-at) list-insert-at))
   (import
     (only (scheme base) begin cond-expand let quote))))


;; list-insert-at

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
