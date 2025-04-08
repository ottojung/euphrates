
(define-library
  (euphrates parselynn-core-grammar-error)
  (export parselynn:core:grammar-error)
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (scheme base)
          apply
          begin
          cons
          define
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-grammar-error.scm")))
    (else (include "parselynn-core-grammar-error.scm"))))
