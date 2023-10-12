
(define-library
  (euphrates parselynn-simple-do-flatten)
  (export parselynn/simple-do-flatten)
  (import (only (euphrates comp) comp))
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
          equal?
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
               "euphrates/parselynn-simple-do-flatten.scm")))
    (else (include "parselynn-simple-do-flatten.scm"))))
