
(define-library
  (euphrates parselynn-simple-do-inline)
  (export parselynn/simple-do-inline)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (scheme base)
          and
          append
          apply
          begin
          car
          cdr
          cond
          define
          else
          list
          list?
          map
          not
          pair?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-do-inline.scm")))
    (else (include "parselynn-simple-do-inline.scm"))))
