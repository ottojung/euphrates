
(define-library
  (euphrates compose-under-seq)
  (export compose-under-seq)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/compose-under-seq.scm")))
    (else (include "compose-under-seq.scm"))))
