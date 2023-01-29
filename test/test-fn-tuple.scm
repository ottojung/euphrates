
(cond-expand
 (guile
  (define-module (test-fn-tuple)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates fn-tuple) :select (fn-tuple))
    :use-module ((euphrates list-zip-with) :select (list-zip-with))
    :use-module ((euphrates range) :select (range)))))


(let () ;; fn-tuple
  (assert= '((0 2) (2 3) (4 4))
           (map (fn-tuple (lambda (x) (* x 2)) (lambda (x) (+ x 2)))
                (list-zip-with list (range 3) (range 3)))))
