
(cond-expand
 (guile
  (define-module (test-list-zip-with)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-zip-with) :select (list-zip-with)))))


(let () ;; list-zip-with
  (assert= '((1 a) (2 b) (3 c))
           (list-zip-with list '(1 2 3) '(a b c)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2 3) '(a b)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2) '(a b)))
  (assert= '((1 a) (2 b))
           (list-zip-with list '(1 2) '(a b c)))
  (assert= '()
           (list-zip-with list '() '(a b c)))
  )
