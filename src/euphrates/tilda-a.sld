
(define-library
  (euphrates tilda-a)
  (export ~a)
  (import
    (only (euphrates stringf) stringf)
    (only (scheme base)
          begin
          cond
          define
          else
          number->string
          number?
          string?
          symbol->string
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/tilda-a.scm")))
    (else (include "tilda-a.scm"))))
