
(define-library
  (euphrates list-count)
  (export list-count)
  (import
    (only (scheme base)
          +
          begin
          car
          cdr
          cond
          define
          else
          let
          null?))
  (cond-expand
    (guile (import (only (srfi srfi-1) count)))
    (else (import (only (srfi 1) count))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-count.scm")))
    (else (include "list-count.scm"))))
