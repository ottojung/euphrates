
(define-library
  (euphrates list-remove-common-prefix)
  (export list-remove-common-prefix)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          define
          else
          eq?
          let
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-remove-common-prefix.scm")))
    (else (include "list-remove-common-prefix.scm"))))
