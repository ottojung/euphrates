
(define-library
  (euphrates parselynn-lr-parsing-table-compile)
  (export parselynn:lr-parsing-table:compile)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates
            bnf-alist-production-get-argument-bindings)
          bnf-alist:production:get-argument-bindings))
  (import
    (only (euphrates bnf-alist-production-lhs)
          bnf-alist:production:lhs))
  (import
    (only (euphrates bnf-alist-production-rhs)
          bnf-alist:production:rhs))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-count
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-take-n) list-take-n))
  (import
    (only (euphrates
            parselynn-core-conflict-handler-default)
          parselynn:core:conflict-handler/default))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates parselynn-lr-accept-action)
          parselynn:lr-accept-action?))
  (import
    (only (euphrates parselynn-lr-action-print)
          parselynn:lr-action:print))
  (import
    (only (euphrates parselynn-lr-goto-action)
          parselynn:lr-goto-action:target-id
          parselynn:lr-goto-action?))
  (import
    (only (euphrates parselynn-lr-parse-conflict)
          parselynn:lr-parse-conflict:actions
          parselynn:lr-parse-conflict?))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:action:list
          parselynn:lr-parsing-table:action:ref
          parselynn:lr-parsing-table:goto:keys
          parselynn:lr-parsing-table:goto:ref
          parselynn:lr-parsing-table:state:keys))
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
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          -
          =
          append
          apply
          begin
          case
          cdr
          cond
          cons
          define
          else
          if
          lambda
          length
          let
          list
          map
          null?
          number->string
          or
          quasiquote
          quote
          reverse
          string->symbol
          string-append
          symbol->string
          unquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parsing-table-compile.scm")))
    (else (include
            "parselynn-lr-parsing-table-compile.scm"))))
