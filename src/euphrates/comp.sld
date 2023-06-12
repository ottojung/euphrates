
(define-library
  (euphrates comp)
  (export comp appcomp)
  (import
    (only (euphrates compose) compose)
    (only (euphrates partial-apply1) partial-apply1)
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/comp.scm")))
    (else (include "comp.scm"))))
