
(cond-expand
 (guile
  (define-module (test-list-chunks)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-chunks) :select (list-chunks)))))

;; list-chunks

(let ()

  (assert=
   '((1 2) (3 4) (5 6))
   (list-chunks 2 '(1 2 3 4 5 6)))

  (assert=
   '((1) (2) (3) (4) (5) (6))
   (list-chunks 1 '(1 2 3 4 5 6)))

  (assert=
   '()
   (list-chunks 2 '()))

  (assert=
   '((1 2 3) (4 5 6) (7 8))
   (list-chunks 3 '(1 2 3 4 5 6 7 8)))

  )
