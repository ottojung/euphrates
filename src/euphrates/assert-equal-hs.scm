
(cond-expand
 (guile
  (define-module (euphrates assert-equal-hs)
    :export (assert=HS)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates multiset) :select (make-multiset multiset-equal?)))))



(define (equal/multiset? a b)
  (multiset-equal? (make-multiset a) (make-multiset b)))

(define-syntax-rule (assert=HS A B)
  (assert (equal/multiset? A B)))

