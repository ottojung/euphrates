
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
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates lalr-lexer-irregex)
          make-lalr-lexer/irregex-factory))
  (import
    (only (euphrates lalr-parser-simple-check-options)
          lalr-parser/simple-check-options))
  (import
    (only (euphrates lalr-parser-simple-check-set)
          lalr-parser/simple-check-set))
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
          begin
          car
          cons
          define
          define-values
          if
          lambda
          list
          map
          memq
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple.scm")))
    (else (include "lalr-parser-simple.scm"))))
