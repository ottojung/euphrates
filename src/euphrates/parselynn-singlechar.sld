
(define-library
  (euphrates parselynn-singlechar)
  (export make-parselynn/singlechar)
  (import (only (euphrates assoc-or) assoc-or))
  (import (only (euphrates debugs) debugs))
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
    (only (euphrates labelinglogic-model-evaluate-first)
          labelinglogic:model:evaluate/first))
  (import
    (only (euphrates
            labelinglogic-model-to-minimal-dnf-assuming-nointersect)
          labelinglogic:model:to-minimal-dnf/assuming-nointersect))
  (import
    (only (euphrates parselynn-singlechar-model)
          parselynn-singlechar-model))
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
          member
          or
          quote
          string->list
          string?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-singlechar.scm")))
    (else (include "parselynn-singlechar.scm"))))
