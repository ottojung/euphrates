
(define-library
  (euphrates parselynn-simple-do-transform)
  (export parselynn/simple-do-transform)
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (scheme base)
          and
          apply
          begin
          car
          cdr
          cond
          define
          else
          if
          let
          list?
          map
          not
          pair?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-do-transform.scm")))
    (else (include "parselynn-simple-do-transform.scm"))))
