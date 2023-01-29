
(cond-expand
 (guile
  (define-module (test-fp)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates fp) :select (fp))
    :use-module ((euphrates list-zip-with) :select (list-zip-with))
    :use-module ((euphrates range) :select (range)))))


(let () ;; fp
  (assert= '((0 2) (2 3) (4 4))
           (map (fp (x y) (list (* x 2) (+ y 2)))
                (list-zip-with list (range 3) (range 3)))))
