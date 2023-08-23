
(define-library
  (euphrates generic-ebnf-tree-to-alist)
  (export generic-ebnf-tree->alist)
  (import
    (only (euphrates bnf-alist-map-expansion-terms)
          bnf-alist:map-expansion-terms))
  (import
    (only (euphrates generic-bnf-tree-to-alist)
          generic-bnf-tree->alist))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          list->hashset))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-length-geq-q)
          list-length=<?))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          *
          +
          /
          =
          append
          begin
          cadr
          car
          cdr
          cond
          cons
          define
          else
          equal?
          if
          lambda
          let
          list
          list?
          map
          not
          number->string
          or
          quasiquote
          quote
          reverse
          string->symbol
          string-append
          symbol?
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-ebnf-tree-to-alist.scm")))
    (else (include "generic-ebnf-tree-to-alist.scm"))))
