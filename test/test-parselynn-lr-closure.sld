
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
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-equal?
          hashset-has?
          list->hashset
          make-hashset))
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
          parselynn:lr-item:next-symbol
          parselynn:lr-item:print))
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
          current-output-port
          define
          define-syntax
          for-each
          lambda
          let
          list
          map
          parameterize
          quasiquote
          quote
          string->symbol
          string<?
          syntax-rules
          unless
          unquote
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-closure.scm")))
    (else (include "test-parselynn-lr-closure.scm"))))
