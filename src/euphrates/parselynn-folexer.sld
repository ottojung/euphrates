
(define-library
  (euphrates parselynn-folexer)
  (export make-parselynn:folexer)
  (import
    (only (euphrates define-pair) define-pair))
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
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
    (only (euphrates labelinglogic-model-append)
          labelinglogic:model:append))
  (import
    (only (euphrates labelinglogic-model-bindings)
          labelinglogic:model:bindings))
  (import
    (only (euphrates labelinglogic-model-check)
          labelinglogic:model:check))
  (import
    (only (euphrates
            labelinglogic-model-to-minimal-dnf-assuming-nointersect)
          labelinglogic:model:to-minimal-dnf/assuming-nointersect))
  (import
    (only (euphrates parselynn-folexer-expression-check)
          parselynn:folexer:expression:check))
  (import
    (only (euphrates
            parselynn-folexer-expression-to-labelinglogic-expression)
          parselynn:folexer:expression->labelinglogic:expression))
  (import
    (only (euphrates parselynn-folexer-model)
          parselynn-folexer-model))
  (import
    (only (euphrates parselynn-folexer-struct)
          make-parselynn:folexer-struct))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (euphrates unique-identifier-to-symbol-recursive)
          unique-identifier->symbol/recursive))
  (import
    (only (scheme base)
          =
          and
          begin
          cond
          cons
          define
          else
          for-each
          if
          lambda
          let
          list
          map
          member
          null?
          or
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer.scm")))
    (else (include "parselynn-folexer.scm"))))
