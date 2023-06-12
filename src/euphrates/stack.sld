
(define-library
  (euphrates stack)
  (export
    stack-make
    stack?
    stack-empty?
    stack-push!
    stack-pop!
    stack-peek
    stack-discard!
    stack->list
    list->stack
    stack-unload!)
  (import
    (only (euphrates raisu) raisu)
    (only (euphrates stack-obj)
          set-stack-lst!
          stack-constructor
          stack-lst
          stack-predicate)
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          if
          let
          null?
          quote
          unless
          when)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/stack.scm")))
    (else (include "stack.scm"))))
