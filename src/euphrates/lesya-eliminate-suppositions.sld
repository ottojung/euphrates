(define-library
  (euphrates lesya-eliminate-suppositions)
  (export lesya:eliminate-suppositions)
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
               "euphrates/lesya-eliminate-suppositions.scm")))
    (else (include "lesya-eliminate-suppositions.scm"))))
