
(define-library
  (test-labelinglogic-expression-optimize-and-assuming-nointersect)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-and-assuming-nointersect)
          labelinglogic:expression:optimize/and-assuming-nointersect))
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
               "test-labelinglogic-expression-optimize-and-assuming-nointersect.scm")))
    (else (include
            "test-labelinglogic-expression-optimize-and-assuming-nointersect.scm"))))
