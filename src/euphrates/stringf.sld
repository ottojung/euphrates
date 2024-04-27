
(define-library
  (euphrates stringf)
  (export stringf)
  (import
    (only (euphrates call-with-output-string)
          call-with-output-string))
  (import (only (euphrates fprintf) fprintf))
  (import
    (only (scheme base)
          apply
          begin
          cons
          define
          lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/stringf.scm")))
    (else (include "stringf.scm"))))
