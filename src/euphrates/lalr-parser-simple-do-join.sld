
(define-library
  (euphrates lalr-parser-simple-do-join)
  (export lalr-parser/simple-do-join)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates lalr-parser-simple-flatten1)
          lalr-parser/simple-flatten1))
  (import
    (only (scheme base)
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
          pair?
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-do-join.scm")))
    (else (include "lalr-parser-simple-do-join.scm"))))
