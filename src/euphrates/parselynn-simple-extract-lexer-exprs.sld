
(define-library
  (euphrates parselynn-simple-extract-lexer-exprs)
  (export parselynn:simple:extract-lexer-exprs)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (euphrates bnf-alist-map-expansion-terms)
          bnf-alist:map-expansion-terms))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates fn-cons) fn-cons))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates parselynn-folexer-expression-head-huh)
          parselynn:folexer:expression:head?))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier))
  (import
    (only (scheme base)
          and
          append
          apply
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          for-each
          lambda
          let
          list
          list?
          map
          pair?
          quote
          symbol?
          values
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-extract-lexer-exprs.scm")))
    (else (include
            "parselynn-simple-extract-lexer-exprs.scm"))))
