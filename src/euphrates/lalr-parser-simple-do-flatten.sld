
(define-library
  (euphrates lalr-parser-simple-do-flatten)
  (export lalr-parser/simple-do-flatten)
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
               "euphrates/lalr-parser-simple-do-flatten.scm")))
    (else (include "lalr-parser-simple-do-flatten.scm"))))
