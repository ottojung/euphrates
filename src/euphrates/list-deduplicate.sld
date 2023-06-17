
(define-library
  (euphrates list-deduplicate)
  (export
    list-deduplicate/reverse
    list-deduplicate)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import (only (euphrates identity) identity))
  (import
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
          reverse))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-deduplicate.scm")))
    (else (include "list-deduplicate.scm"))))
