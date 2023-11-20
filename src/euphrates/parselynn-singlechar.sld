
(define-library
  (euphrates parselynn-singlechar)
  (export make-parselynn/singlechar)
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-alpha-rename)
          labelinglogic:model:alpha-rename))
  (import
    (only (euphrates labelinglogic)
          labelinglogic:init))
  (import
    (only (euphrates parselynn-singlechar-struct)
          make-parselynn/singlechar-struct))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          and
          begin
          cadr
          car
          char?
          cond
          cons
          define
          else
          equal?
          for-each
          lambda
          let
          list
          map
          not
          or
          quasiquote
          quote
          string->list
          string?
          unquote))
  (import
    (only (scheme char)
          char-alphabetic?
          char-lower-case?
          char-numeric?
          char-upper-case?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-singlechar.scm")))
    (else (include "parselynn-singlechar.scm"))))
