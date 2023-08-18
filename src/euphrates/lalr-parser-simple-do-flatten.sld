
(define-library
  (euphrates lalr-parser-simple-do-flatten)
  (export lalr-parser/simple-do-flatten)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates lalr-parser-simple-flatten1)
          lalr-parser/simple-flatten1))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          cons
          define
          else
          if
          let
          list?
          map
          pair?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-do-flatten.scm")))
    (else (include "lalr-parser-simple-do-flatten.scm"))))
