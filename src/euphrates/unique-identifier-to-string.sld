
(define-library
  (euphrates unique-identifier-to-string)
  (export unique-identifier->string)
  (import
    (only (euphrates unique-identifier)
          unique-identifier->list))
  (import
    (only (scheme base)
          begin
          cadr
          define
          number->string
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/unique-identifier-to-string.scm")))
    (else (include "unique-identifier-to-string.scm"))))
