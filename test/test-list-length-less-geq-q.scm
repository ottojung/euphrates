
(cond-expand
 (guile
  (define-module (test-list-length-less-geq-q)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates list-length-geq-q) :select (list-length=<?)))))

;; list-length-less-geq-q

(let ()

  (assert (list-length=<? 3 '(1 2 3 4 5 6)))
  (assert (list-length=<? 3 '(1 2 3)))
  (assert (not (list-length=<? 3 '(1 2))))
  (assert (list-length=<? 0 '()))
  (assert (list-length=<? -3 '(1 2)))
  (assert (list-length=<? -3 '()))

  )
