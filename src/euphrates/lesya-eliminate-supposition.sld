(define-library
  (euphrates lesya-eliminate-supposition)
  (export lesya:eliminate-supposition)
  (import
    (only (scheme base)
          >
          and
          begin
          char=?
          define
          string-length
          string-ref
          string?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-eliminate-supposition.scm")))
    (else (include "lesya-eliminate-supposition.scm"))))
