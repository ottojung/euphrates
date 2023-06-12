
(define-library
  (euphrates list-deduplicate)
  (export
    list-deduplicate/reverse
    list-deduplicate)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset)
    (only (euphrates identity) identity)
    (only (scheme base)
          begin
          car
          cdr
          cond
          cons
          define
          else
          let
          null?
          quote
          reverse)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-deduplicate.scm")))
    (else (include "list-deduplicate.scm"))))
