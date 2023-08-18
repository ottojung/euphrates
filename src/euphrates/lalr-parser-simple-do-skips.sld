
(define-library
  (euphrates lalr-parser-simple-do-skips)
  (export lalr-parser/simple-do-skips)
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
               "euphrates/lalr-parser-simple-do-skips.scm")))
    (else (include "lalr-parser-simple-do-skips.scm"))))
