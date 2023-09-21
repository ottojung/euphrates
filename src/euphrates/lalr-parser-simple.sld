
(define-library
  (euphrates lalr-parser-simple)
  (export lalr-parser/simple)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates assq-unset-value)
          assq-unset-value))
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
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates
            lalr-lexer-singlechar-additional-grammar-rules)
          lalr-lexer/singlechar:additional-grammar-rules))
  (import
    (only (euphrates
            lalr-lexer-singlechar-result-as-iterator)
          lalr-lexer/singlechar-result:as-iterator))
  (import
    (only (euphrates lalr-lexer-singlechar-run-on-string)
          lalr-lexer/singlechar:run-on-string))
  (import
    (only (euphrates lalr-lexer-singlechar)
          make-lalr-lexer/singlechar))
  (import
    (only (euphrates lalr-parser-run-with-error-handler)
          lalr-parser-run/with-error-handler))
  (import
    (only (euphrates lalr-parser-simple-check-options)
          lalr-parser/simple-check-options))
  (import
    (only (euphrates lalr-parser-simple-check-set)
          lalr-parser/simple-check-set))
  (import
    (only (euphrates lalr-parser-simple-extract-alist)
          lalr-parser/simple-extract-alist))
  (import
    (only (euphrates lalr-parser-simple-extract-regexes)
          lalr-parser/simple-extract-regexes))
  (import
    (only (euphrates lalr-parser-simple-extract-set)
          lalr-parser/simple-extract-set))
  (import
    (only (euphrates lalr-parser-simple-transform-result)
          lalr-parser/simple-transform-result))
  (import
    (only (euphrates lalr-parser) lalr-parser))
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
          quote
          symbol?
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple.scm")))
    (else (include "lalr-parser-simple.scm"))))
