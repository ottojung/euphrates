
(define-library
  (euphrates replicate)
  (export replicate)
  (import
    (only (scheme base)
          -
          >=
          begin
          cons
          define
          if
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/replicate.scm")))
    (else (include "replicate.scm"))))
