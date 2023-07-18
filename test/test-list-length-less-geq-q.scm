
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates list-length-geq-q)
           list-length=<?))
   (import
     (only (scheme base)
           begin
           cond-expand
           let
           not
           quote))))


;; list-length-less-geq-q

(let ()

  (assert (list-length=<? 3 '(1 2 3 4 5 6)))
  (assert (list-length=<? 3 '(1 2 3)))
  (assert (not (list-length=<? 3 '(1 2))))
  (assert (list-length=<? 0 '()))
  (assert (list-length=<? -3 '(1 2)))
  (assert (list-length=<? -3 '()))

  )
