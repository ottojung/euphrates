
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates comp) comp))
   (import
     (only (euphrates list-windows) list-windows))
   (import
     (only (scheme base)
           +
           apply
           begin
           cond-expand
           let
           map
           quote))))


;; list-windows

(let ()

  (assert=
   '((1 2) (2 3) (3 4) (4 5) (5 6))
   (list-windows 2 '(1 2 3 4 5 6)))

  (assert=
   '((1 2 3) (2 3 4) (3 4 5) (4 5 6))
   (list-windows 3 '(1 2 3 4 5 6)))

  (assert=
   '(6 9 12 15)
   (map (comp (apply +)) (list-windows 3 '(1 2 3 4 5 6))))

  (assert=
   '((1 2 3))
   (list-windows 3 '(1 2 3)))

  (assert=
   '((1) (2) (3))
   (list-windows 1 '(1 2 3)))

  )
