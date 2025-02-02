
(define-library
  (euphrates parselynn-ll-parsing-table-compile)
  (export parselynn:ll-parsing-table:compile)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates
            bnf-alist-production-get-argument-bindings)
          bnf-alist:production:get-argument-bindings))
  (import
    (only (euphrates bnf-alist-production-lhs)
          bnf-alist:production:lhs))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates group-by-sequential)
          group-by/sequential))
  (import (only (euphrates hashset) hashset->list))
  (import
    (only (euphrates object-to-string)
          object->string))
  (import
    (only (euphrates
            parselynn-ll-compile-get-predictor-name)
          parselynn:ll-compile:get-predictor-name))
  (import
    (only (euphrates parselynn-ll-match-action)
          parselynn:ll-match-action:symbol
          parselynn:ll-match-action?))
  (import
    (only (euphrates parselynn-ll-parsing-table)
          parselynn:ll-parsing-table-clause:actions
          parselynn:ll-parsing-table-clause:candidates
          parselynn:ll-parsing-table-clause:production
          parselynn:ll-parsing-table:clauses))
  (import
    (only (euphrates parselynn-ll-predict-action)
          parselynn:ll-predict-action:nonterminal
          parselynn:ll-predict-action?))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates range) range))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          for-each
          if
          lambda
          length
          let
          list
          map
          member
          quasiquote
          quote
          reverse
          string->symbol
          string-append
          string<?
          unquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-parsing-table-compile.scm")))
    (else (include
            "parselynn-ll-parsing-table-compile.scm"))))
