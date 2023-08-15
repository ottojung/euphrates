
(define-library
  (euphrates generic-error-value)
  (export generic-error:value)
  (import
    (only (euphrates generic-error-huh)
          generic-error?))
  (import
    (only (euphrates generic-error-value-unsafe)
          generic-error:value/unsafe))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          let
          quote
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-value.scm")))
    (else (include "generic-error-value.scm"))))
