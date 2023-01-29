
(cond-expand
 (guile
  (define-module (test-list-insert-at)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-insert-at) :select (list-insert-at)))))

;; list-insert-at

(let ()
  (assert= '(a b c d)
           (list-insert-at '(a b d) 2 'c))

  (assert= '(a b c d)
           (list-insert-at '(b c d) 0 'a))

  (assert= '(a b c d)
           (list-insert-at '(a b c) 3 'd))

  (assert= '(a b c d)
           (list-insert-at '(a b c) 999999 'd))

  (assert= '(a b c d)
           (list-insert-at '(a b c) +inf.0 'd)))
