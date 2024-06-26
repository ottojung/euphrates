
(define-library
  (euphrates parselynn-simple)
  (export parselynn:simple)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates assq-unset-multiple-values)
          assq-unset-multiple-values))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates generic-ebnf-tree-to-alist)
          generic-ebnf-tree->alist))
  (import
    (only (euphrates gkeyword) gkeyword->fkeyword))
  (import
    (only (euphrates hashset)
          hashset-null?
          list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates labelinglogic-model-names)
          labelinglogic:model:names))
  (import
    (only (euphrates parselynn-core) parselynn:core))
  (import
    (only (euphrates parselynn-folexer-compile-iterator)
          parselynn:folexer:compile/iterator))
  (import
    (only (euphrates parselynn-folexer-struct)
          parselynn:folexer:additional-grammar-rules
          parselynn:folexer:base-model))
  (import
    (only (euphrates parselynn-folexer)
          make-parselynn:folexer))
  (import
    (only (euphrates parselynn-simple-check-options)
          parselynn:simple:check-options))
  (import
    (only (euphrates parselynn-simple-check-set)
          parselynn:simple:check-set))
  (import
    (only (euphrates parselynn-simple-extract-lexer-exprs)
          parselynn:simple:extract-lexer-exprs))
  (import
    (only (euphrates parselynn-simple-extract-set)
          parselynn:simple:extract-set))
  (import
    (only (euphrates parselynn-simple-handle-calls)
          parselynn:simple:handle-calls))
  (import
    (only (euphrates parselynn-simple-struct)
          make-parselynn:simple:struct))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates semis-ebnf-tree-to-ebnf-tree)
          semis-ebnf-tree->ebnf-tree))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates unique-identifier-to-symbol-recursive)
          unique-identifier->symbol/recursive))
  (import
    (only (euphrates unique-identifier)
          with-unique-identifier-context))
  (import
    (only (scheme base)
          +
          /
          =
          and
          append
          apply
          begin
          car
          cdr
          cons
          define
          define-values
          for-each
          if
          lambda
          length
          list
          map
          memq
          not
          number->string
          quote
          string
          string->symbol
          string-append
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter iota)))
    (else (import (only (srfi 1) filter iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple.scm")))
    (else (include "parselynn-simple.scm"))))
