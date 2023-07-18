
(define-library
  (test-compose-under-seq)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates compose-under-seq)
          compose-under-seq))
  (import
    (only (scheme base)
          *
          +
          -
          =
          and
          begin
          cond-expand
          define
          even?
          let
          or
          quotient))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-compose-under-seq.scm")))
    (else (include "test-compose-under-seq.scm"))))
