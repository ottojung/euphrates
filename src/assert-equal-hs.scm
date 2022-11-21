
%run guile

%use (assert) "./assert.scm"
%use (make-multiset multiset-equal?) "./multiset.scm"

%var assert=HS

(define (equal/multiset? a b)
  (multiset-equal? (make-multiset a) (make-multiset b)))

(define-syntax-rule (assert=HS A B)
  (assert (equal/multiset? A B)))

