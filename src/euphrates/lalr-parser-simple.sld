
(define-library
  (euphrates lalr-parser-simple)
  (export lalr-parser/simple)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates assq-unset-value)
          assq-unset-value))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates const) const))
  (import (only (euphrates curry-if) curry-if))
  (import (only (euphrates fn-cons) fn-cons))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates generic-ebnf-tree-to-alist)
          generic-ebnf-tree->alist))
  (import
    (only (euphrates gkeyword) gkeyword->fkeyword))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates identity) identity))
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
    (only (euphrates lalr-parser-simple-remove-spines)
          lalr-parser/simple-remove-spines))
  (import
    (only (euphrates lalr-parser-simple-transform-result)
          lalr-parser/simple-transform-result))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates semis-ebnf-tree-to-ebnf-tree)
          semis-ebnf-tree->ebnf-tree))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
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
          cond
          cons
          define
          define-values
          else
          equal?
          if
          lambda
          let
          list
          list?
          map
          member
          memq
          or
          pair?
          quote
          string->symbol
          string-append
          string?
          unless
          values
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple.scm")))
    (else (include "lalr-parser-simple.scm"))))
