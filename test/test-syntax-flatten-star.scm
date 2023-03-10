
(cond-expand
 (guile
  (define-module (test-syntax-flatten-star)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates syntax-flatten-star) :select (syntax-flatten*)))))


(let () ;; syntax-flatten-star
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg (quote buf)))))

  (assert= (list 'arg '(a b c g h d h e))
           (syntax-flatten* (cont 'arg) ((a b (c (g h) d) (h) e)))))
