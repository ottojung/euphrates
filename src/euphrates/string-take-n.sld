
(define-library
  (euphrates string-take-n)
  (export string-take-n)
  (import
    (only (scheme base)
          begin
          define
          max
          min
          string-length
          substring))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/string-take-n.scm")))
    (else (include "string-take-n.scm"))))
