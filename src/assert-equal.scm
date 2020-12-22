
%run guile

%use (assert) "./assert.scm"

%var assert=

(define-syntax-rule (assert= a b . printf-args)
  (assert (equal? a b) . printf-args))
