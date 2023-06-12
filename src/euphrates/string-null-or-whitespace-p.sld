
(define-library
  (euphrates string-null-or-whitespace-p)
  (export string-null-or-whitespace?)
  (import
    (only (scheme base)
          -
          <
          begin
          case
          define
          else
          if
          let
          string-length
          string-ref))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-null-or-whitespace-p.scm")))
    (else (include "string-null-or-whitespace-p.scm"))))
