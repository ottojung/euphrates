
(define-library
  (euphrates parselynn-simple)
  (export parselynn/simple)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates assq-unset-multiple-values)
          assq-unset-multiple-values))
  (import (only (euphrates comp) appcomp))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates generic-ebnf-tree-to-alist)
          generic-ebnf-tree->alist))
  (import
    (only (euphrates gkeyword) gkeyword->fkeyword))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-delete!
          hashset-foreach
          hashset-has?
          list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates
            parselynn-singlechar-additional-grammar-rules)
          parselynn/singlechar:additional-grammar-rules))
  (import
    (only (euphrates parselynn-singlechar)
          make-parselynn/singlechar))
  (import
    (only (euphrates parselynn-simple-check-options)
          parselynn/simple-check-options))
  (import
    (only (euphrates parselynn-simple-check-set)
          parselynn/simple-check-set))
  (import
    (only (euphrates parselynn-simple-extract-regexes)
          parselynn/simple-extract-regexes))
  (import
    (only (euphrates parselynn-simple-extract-set)
          parselynn/simple-extract-set))
  (import
    (only (euphrates parselynn-simple-struct)
          make-parselynn/simple-struct))
  (import
    (only (euphrates parselynn) parselynn))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates semis-ebnf-tree-to-ebnf-tree)
          semis-ebnf-tree->ebnf-tree))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          /
          =
          and
          append
          begin
          car
          cond
          cons
          define
          define-values
          for-each
          if
          lambda
          let
          list
          list?
          map
          memq
          not
          null?
          quote
          symbol?
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple.scm")))
    (else (include "parselynn-simple.scm"))))
