
(define-library
  (euphrates lalr-parser-simple)
  (export lalr-parser/simple)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates bnf-tree-to-alist)
          bnf-tree->alist))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates gkeyword)
          gkeyword->fkeyword
          gkeyword?))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates lalr-lexer-latin)
          make-lalr-lexer/latin))
  (import
    (only (euphrates lalr-lexr-latin-tokens)
          lalr-lexr/latin-tokens))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          car
          cons
          define
          if
          lambda
          let
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
