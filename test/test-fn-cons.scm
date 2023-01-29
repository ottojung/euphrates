
(cond-expand
 (guile
  (define-module (test-fn-cons)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates fn-cons) :select (fn-cons))
    :use-module ((euphrates list-zip-with) :select (list-zip-with))
    :use-module ((euphrates range) :select (range)))))


(let () ;; fn-cons
  (assert= '((0 . 2) (2 . 3) (4 . 4))
           (map (fn-cons (lambda (x) (* x 2)) (lambda (x) (+ x 2)))
                (list-zip-with cons (range 3) (range 3))))
  (assert= (cons 5 (cons 8 25))
           ((fn-cons (lambda (x) (+ x 2))
                     (lambda (x) (* x 2))
                     (lambda (x) (expt (car x) 2)))
            (cons 3 (cons 4 (cons 5 6)))))
  (assert= (cons 5 (cons 8 (cons 25 4)))
           ((fn-cons (lambda (x) (+ x 2))
                     (lambda (x) (* x 2))
                     (lambda (x) (expt x 2))
                     (lambda (x) (- x 2)))
            (cons 3 (cons 4 (cons 5 6))))))
