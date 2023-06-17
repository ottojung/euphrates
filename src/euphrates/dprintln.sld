
(define-library
  (euphrates dprintln)
  (export dprintln)
  (import (only (euphrates conss) conss))
  (import (only (euphrates dprint) dprint))
  (import
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
