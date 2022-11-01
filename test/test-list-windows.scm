
%run guile

;; list-windows
%use (assert=) "./src/assert-equal.scm"
%use (comp) "./src/comp.scm"
%use (list-windows) "./src/list-windows.scm"

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
