
(cond-expand
 (guile
  (define-module (test-fn-pair)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates fn-pair) :select (fn-pair))
    :use-module ((euphrates list-zip-with) :select (list-zip-with))
    :use-module ((euphrates range) :select (range)))))


(assert= '((0 . 2) (2 . 3) (4 . 4))
         (map (fn-pair (a b) (cons (* a 2) (+ b 2)))
              (list-zip-with cons (range 3) (range 3))))
