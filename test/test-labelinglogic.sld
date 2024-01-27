
(define-library
  (test-labelinglogic)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import (only (euphrates dprintln) dprintln))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-move-nots-down)
          labelinglogic:expression:move-nots-down))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          and
          begin
          boolean?
          car
          cdr
          cond
          define
          else
          eq?
          equal?
          error
          if
          lambda
          let
          list
          map
          member
          not
          null?
          or
          pair?
          quasiquote
          quote
          symbol?
          unquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-labelinglogic.scm")))
    (else (include "test-labelinglogic.scm"))))
