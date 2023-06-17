
(define-library
  (euphrates comp)
  (export comp appcomp)
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates partial-apply1) partial-apply1))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/comp.scm")))
    (else (include "comp.scm"))))
