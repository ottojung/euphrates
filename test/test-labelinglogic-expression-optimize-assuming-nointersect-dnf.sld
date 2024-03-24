
(define-library
  (test-labelinglogic-expression-optimize-assuming-nointersect-dnf)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-assuming-nointersect-dnf)
          labelinglogic:expression:optimize/assuming-nointersect-dnf))
  (import
    (only (scheme base)
          =
          and
          begin
          define
          equal?
          even?
          integer?
          negative?
          not
          odd?
          or
          positive?
          quote
          zero?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-optimize-assuming-nointersect-dnf.scm")))
    (else (include
            "test-labelinglogic-expression-optimize-assuming-nointersect-dnf.scm"))))
