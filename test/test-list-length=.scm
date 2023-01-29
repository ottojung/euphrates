
(cond-expand
 (guile
  (define-module (test-list-length=)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates list-length-eq) :select (list-length=)))))

;; list-length=

(let ()

  (assert (not (list-length= 3 '(1 2 3 4 5 6))))
  (assert (list-length= 3 '(1 2 3)))
  (assert (not (list-length= 3 '(1 2))))
  (assert (list-length= 0 '()))
  (assert (not (list-length= -3 '(1 2))))
  (assert (not (list-length= -3 '())))

  )
