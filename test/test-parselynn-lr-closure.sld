
(define-library
  (test-parselynn-lr-closure)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates bnf-alist-assoc-productions)
          bnf-alist:assoc-productions))
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import
    (only (euphrates bnf-alist-terminals)
          bnf-alist:terminals))
  (import
    (only (euphrates cartesian-map) cartesian-map))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-lr-item-next-lookaheads)
          parselynn:lr-item:next-lookaheads))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:advance
          parselynn:lr-item:make
          parselynn:lr-item:next-symbol))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:add!
          parselynn:lr-state:has?
          parselynn:lr-state:make
          parselynn:lr-state:print))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          *
          +
          =
          _
          and
          begin
          define
          define-syntax
          for-each
          lambda
          let
          list
          quasiquote
          quote
          string->symbol
          syntax-rules
          unless
          unquote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-closure.scm")))
    (else (include "test-parselynn-lr-closure.scm"))))
