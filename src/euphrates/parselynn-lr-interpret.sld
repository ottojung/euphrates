
(define-library
  (euphrates parselynn-lr-interpret)
  (export parselynn:lr-interpret)
  (import
    (only (euphrates bnf-alist-production-lhs)
          bnf-alist:production:lhs))
  (import
    (only (euphrates bnf-alist-production-rhs)
          bnf-alist:production:rhs))
  (import
    (only (euphrates iterator) iterator:next))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-lr-accept-action)
          parselynn:lr-accept-action?))
  (import
    (only (euphrates parselynn-lr-action-print)
          parselynn:lr-action:print))
  (import
    (only (euphrates parselynn-lr-goto-action)
          parselynn:lr-goto-action:target-id))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:action:ref
          parselynn:lr-parsing-table:goto:ref
          parselynn:lr-parsing-table:start-symbol
          parselynn:lr-parsing-table:state:initial))
  (import
    (only (euphrates parselynn-lr-reduce-action)
          parselynn:lr-reduce-action:production
          parselynn:lr-reduce-action?))
  (import
    (only (euphrates parselynn-lr-reject-action)
          parselynn:lr-reject-action:make
          parselynn:lr-reject-action?))
  (import
    (only (euphrates parselynn-lr-shift-action)
          parselynn:lr-shift-action:target-id
          parselynn:lr-shift-action?))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-peek
          stack-pop!
          stack-pop-multiple!
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          _
          begin
          car
          cond
          define
          else
          for-each
          if
          lambda
          length
          let
          list
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-interpret.scm")))
    (else (include "parselynn-lr-interpret.scm"))))
