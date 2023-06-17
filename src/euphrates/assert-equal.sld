
(define-library
  (euphrates assert-equal)
  (export assert=)
  (import (only (euphrates assert) assert))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          equal?
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assert-equal.scm")))
    (else (include "assert-equal.scm"))))
