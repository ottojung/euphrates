
(define-library
  (euphrates string-null-or-whitespace-p)
  (export string-null-or-whitespace?)
  (import
    (only (scheme base)
          -
          <
          and
          begin
          cond-expand
          define
          if
          let
          string-length
          string-ref))
  (import (only (scheme char) char-whitespace?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-null-or-whitespace-p.scm")))
    (else (include "string-null-or-whitespace-p.scm"))))
