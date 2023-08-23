
(define-library
  (euphrates lalr-parser-simple-do-transform)
  (export lalr-parser/simple-do-transform)
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
               "euphrates/lalr-parser-simple-do-transform.scm")))
    (else (include "lalr-parser-simple-do-transform.scm"))))
