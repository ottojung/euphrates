
(define (equal/multiset? a b)
  (multiset-equal? (list->multiset a) (list->multiset b)))

(define-syntax assert=HS
  (syntax-rules ()
    ((_ A B)
     (assert (equal/multiset? A B)))))
