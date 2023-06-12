
(define-library
  (euphrates profun-instruction)
  (export
    profun-instruction-constructor
    profun-instruction?
    profun-instruction-name
    profun-instruction-body
    profun-instruction-args
    profun-instruction-arity
    profun-instruction-next
    profun-instruction-context
    profun-instruction-build
    profun-instruction-build/next)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          length
          let
          null?
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-instruction.scm")))
    (else (include "profun-instruction.scm"))))
