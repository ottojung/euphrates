
(define-library
  (euphrates parselynn-simple-do-join)
  (export parselynn:simple:do-join)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates parselynn-simple-join1)
          parselynn:simple:join1))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          define
          else
          if
          let
          list
          list?
          map
          not
          pair?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-do-join.scm")))
    (else (include "parselynn-simple-do-join.scm"))))
