
(define-library
  (euphrates define-tuple)
  (export define-tuple)
  (import
    (only (scheme base)
          _
          apply
          begin
          define
          define-syntax
          define-values
          syntax-rules
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/define-tuple.scm")))
    (else (include "define-tuple.scm"))))
