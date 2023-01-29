
(cond-expand
 (guile
  (define-module (test-list-zip)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-zip) :select (list-zip)))))


(let () ;; list-zip
  (assert= '((1 . a) (2 . b) (3 . c))
           (list-zip '(1 2 3) '(a b c)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2 3) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip '(1 2) '(a b c)))
  (assert= '()
           (list-zip '() '(a b c)))
  )
