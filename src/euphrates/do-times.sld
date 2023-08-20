
(define-library
  (euphrates do-times)
  (export do-times)
  (import
    (only (scheme base)
          -
          <
          _
          begin
          define-syntax
          let
          syntax-rules
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/do-times.scm")))
    (else (include "do-times.scm"))))
