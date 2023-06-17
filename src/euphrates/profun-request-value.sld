
(define-library
  (euphrates profun-request-value)
  (export profun-request-value)
  (import
    (only (euphrates profun-RFC) make-profun-RFC))
  (import
    (only (scheme base)
          begin
          define
          quasiquote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-request-value.scm")))
    (else (include "profun-request-value.scm"))))
