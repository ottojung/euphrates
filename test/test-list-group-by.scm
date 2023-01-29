
(cond-expand
 (guile
  (define-module (test-list-group-by)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS))
    :use-module ((euphrates list-group-by) :select (list-group-by)))))


(let () ;; list-group-by
  (assert=HS '((#t 4 2) (#f 5 3 1))
             (list-group-by even? '(1 2 3 4 5)))
  (assert=HS '((0 3) (1 4 1) (2 5 2))
             (list-group-by (lambda (x) (modulo x 3)) '(1 2 3 4 5)))
  )
