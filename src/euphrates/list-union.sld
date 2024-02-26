
(define-library
  (euphrates list-union)
  (export list-union)
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (scheme base)
          append
          begin
          car
          cdr
          cons
          define
          if
          let
          not
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-union.scm")))
    (else (include "list-union.scm"))))
