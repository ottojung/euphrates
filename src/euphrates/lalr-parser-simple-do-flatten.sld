
(define-library
  (euphrates lalr-parser-simple-do-flatten)
  (export lalr-parser/simple-do-flatten)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates list-collapse) list-collapse))
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
          string-append
          string?))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-do-flatten.scm")))
    (else (include "lalr-parser-simple-do-flatten.scm"))))
