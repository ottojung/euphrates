
(cond-expand
 (guile
  (define-module (test-list-take-while)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-take-while) :select (list-take-while)))))

;; list-take-while

(let ()
  (assert= '(2 4 6 8) (list-take-while even? '(2 4 6 8 9 3 1)))
  (assert= '() (list-take-while even? '(1 2 4 6 8 9 3 1)))
  (assert= '() (list-take-while even? '()))
  (assert= '(2 4 6 8) (list-take-while even? '(2 4 6 8)))
  )
