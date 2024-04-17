
(define-library
  (euphrates parselynn-simple-flatten1)
  (export parselynn:simple:flatten1)
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          for-each
          if
          let
          pair?
          reverse
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-flatten1.scm")))
    (else (include "parselynn-simple-flatten1.scm"))))
