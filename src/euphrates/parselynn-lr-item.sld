
(define-library
  (euphrates parselynn-lr-item)
  (export parselynn:lr-item)
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
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-equal?
          hashset-has?
          list->hashset
          make-hashset))
  (import
    (only (euphrates list-drop-n) list-drop-n))
  (import
    (only (euphrates list-take-n) list-take-n))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-epsilon)
          parselynn:epsilon))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          +
          >=
          and
          append
          begin
          car
          cdr
          cond
          current-output-port
          define
          else
          equal?
          for-each
          if
          lambda
          length
          let
          list
          list-ref
          null?
          parameterize
          quote
          unless
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-item.scm")))
    (else (include "parselynn-lr-item.scm"))))
