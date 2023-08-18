
(define-library
  (euphrates lalr-parser-simple-transform-result)
  (export lalr-parser/simple-transform-result)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import
    (only (scheme base)
          append
          apply
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
          null?
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
               "euphrates/lalr-parser-simple-transform-result.scm")))
    (else (include
            "lalr-parser-simple-transform-result.scm"))))
