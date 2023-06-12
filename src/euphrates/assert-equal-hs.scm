
(define (equal/multiset? a b)
  (multiset-equal? (make-multiset a) (make-multiset b)))

(define-syntax assert=HS
  (syntax-rules ()
    ((_ A B)
     (assert (equal/multiset? A B)))))
