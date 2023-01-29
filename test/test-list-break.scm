
(cond-expand
 (guile
  (define-module (test-list-break)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-break) :select (list-break)))))

;; list-break

(let ()
  (define-values (a1 a2)
    (list-break even? '(3 5 7 2 1 9)))

  (assert= a1 '(3 5 7))
  (assert= a2 '(2 1 9)))
