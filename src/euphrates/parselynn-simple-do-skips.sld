
(define-library
  (euphrates parselynn-simple-do-skips)
  (export parselynn/simple-do-skips)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (scheme base)
          append
          apply
          begin
          car
          cond
          define
          else
          if
          let
          list
          list?
          map
          not
          null?
          pair?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-do-skips.scm")))
    (else (include "parselynn-simple-do-skips.scm"))))
