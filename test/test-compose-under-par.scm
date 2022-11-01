
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (compose-under-par) "./src/compose-under-par.scm"
%use (range) "./src/range.scm"

(let () ;; compose-under-par
  (assert= (list 5 5 -5)
           ((compose-under-par list + * -) 5 5 5))
  (assert= '((2 0) (3 2) (4 4))
           (map (compose-under-par
                 list (lambda (x) (+ 2 x)) (lambda (x) (* 2 x)))
                (range 3) (range 3))))
