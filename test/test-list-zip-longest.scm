
(let () ;; list-zip-longest
  (define fill-value 'x)

  (assert= '((1 . a) (2 . b) (3 . c))
           (list-zip-longest fill-value '(1 2 3) '(a b c)))
  (assert= '((1 . a) (2 . b) (3 . x))
           (list-zip-longest fill-value '(1 2 3) '(a b)))
  (assert= '((1 . a) (2 . b))
           (list-zip-longest fill-value '(1 2) '(a b)))
  (assert= '((1 . a) (2 . b) (x . c))
           (list-zip-longest fill-value '(1 2) '(a b c)))
  (assert= '((x . a) (x . b) (x . c))
           (list-zip-longest fill-value '() '(a b c)))
  )
