
(define-library
  (euphrates parselynn-folexer)
  (export make-parselynn:folexer)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates hashmap)
          hashmap-has?
          hashmap-set!
          make-hashmap))
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
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
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
    (only (euphrates parselynn-folexer-model)
          parselynn-folexer-model))
  (import
    (only (euphrates parselynn-folexer-struct)
          make-parselynn:folexer-struct))
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
    (only (euphrates unique-identifier-to-symbol-recursive)
          unique-identifier->symbol/recursive))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier
          with-unique-identifier-context))
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
          if
          lambda
          let
          list
          map
          member
          not
          or
          quote
          reverse
          string->list
          string-for-each
          string-length
          string-ref
          string?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer.scm")))
    (else (include "parselynn-folexer.scm"))))
