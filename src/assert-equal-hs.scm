
%run guile

%use (assert) "./assert.scm"
%use (make-hashset hashset-equal?) "./ihashset.scm"

%var assert=HS

(define (equal/hashset? a b)
  (hashset-equal? (make-hashset a) (make-hashset b)))

(define-syntax-rule (assert=HS A B)
  (assert (equal/hashset? A B)))

