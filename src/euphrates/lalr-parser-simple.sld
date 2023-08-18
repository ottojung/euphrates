
(define-library
  (euphrates lalr-parser-simple)
  (export lalr-parser/simple)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (euphrates assq-unset-value)
          assq-unset-value))
  (import
    (only (euphrates bnf-tree-to-alist)
          bnf-tree->alist))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates fn-cons) fn-cons))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates gkeyword)
          gkeyword->fkeyword
          gkeyword?))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates lalr-lexer-irregex)
          make-lalr-lexer/irregex))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import (only (euphrates list-fold) list-fold))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          =
          _
          append
          apply
          begin
          car
          cdr
          cons
          define
          if
          lambda
          let
          list
          map
          memq
          quote
          string->symbol
          string-append
          string?
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
