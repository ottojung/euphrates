
(define-library
  (euphrates assert-equal-hs)
  (export assert=HS)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates multiset)
          make-multiset
          multiset-equal?))
  (import
    (only (scheme base)
          _
          begin
          define
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/assert-equal-hs.scm")))
    (else (include "assert-equal-hs.scm"))))
