
(define-library
  (test-zoreslava)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates zoreslava)
          with-zoreslava
          zoreslava/p
          zoreslava:deserialize
          zoreslava:equal?
          zoreslava:ref
          zoreslava:serialize
          zoreslava:set!))
  (import
    (only (scheme base) begin define let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-zoreslava.scm")))
    (else (include "test-zoreslava.scm"))))
