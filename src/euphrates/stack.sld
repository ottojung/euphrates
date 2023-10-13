
(define-library
  (euphrates stack)
  (export
    stack-make
    stack?
    stack-empty?
    stack-has?
    stack-push!
    stack-pop!
    stack-peek
    stack-discard!
    stack->list
    list->stack
    stack-unload!)
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates stack-obj)
          set-stack-lst!
          stack-constructor
          stack-lst
          stack-predicate))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          if
          let
          member
          null?
          quote
          unless
          when))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/stack.scm")))
    (else (include "stack.scm"))))
