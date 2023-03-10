
(cond-expand
 (guile
  (define-module (test-list-split-on)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-split-on) :select (list-split-on)))))

;; list-split-on

(let ()
  (assert= '((1) (3) (5) (7))
           (list-split-on even? (list 1 2 3 4 5 6 7)))
  (assert= '((1 3 5 7) (9))
           (list-split-on even? (list 1 3 5 7 2 9)))
  (assert= '((1 3 5 7))
           (list-split-on even? (list 1 3 5 7)))
  (assert= '((1 3) (5 7))
           (list-split-on even? (list 1 3 2 2 5 7)))
  (assert= '()
           (list-split-on even? (list 2 4 6)))
  )
