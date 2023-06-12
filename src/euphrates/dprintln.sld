
(define-library
  (euphrates dprintln)
  (export dprintln)
  (import
    (only (euphrates conss) conss)
    (only (euphrates dprint) dprint)
    (only (scheme base)
          apply
          begin
          define
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/dprintln.scm")))
    (else (include "dprintln.scm"))))
