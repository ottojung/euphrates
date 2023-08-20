
(define-library
  (euphrates list-number-average)
  (export list-number-average)
  (import
    (only (scheme base)
          +
          /
          =
          begin
          car
          cdr
          define
          if
          let
          null?))
  (cond-expand
    (guile (import (only (srfi srfi-1) count)))
    (else (import (only (srfi 1) count))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-number-average.scm")))
    (else (include "list-number-average.scm"))))
