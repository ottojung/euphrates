
(define-library
  (euphrates compile-cfg-cli)
  (export
    CFG-AST->CFG-lang
    CFG-CLI->CFG-lang
    CFG-lang-modifier-char?)
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates hashset)
          hashset-has?
          make-hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates parse-cfg-cli) CFG-CLI->CFG-AST))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          *
          +
          =
          and
          assoc
          begin
          cadr
          car
          case
          cdr
          cond
          cons
          define
          define-values
          else
          if
          lambda
          let
          list
          list->string
          map
          not
          null?
          or
          pair?
          quasiquote
          quote
          reverse
          string->list
          string->symbol
          unquote
          unquote-splicing
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import
             (only (srfi srfi-13)
                   string-prefix?
                   string-suffix?)))
    (else (import
            (only (srfi 13) string-prefix? string-suffix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/compile-cfg-cli.scm")))
    (else (include "compile-cfg-cli.scm"))))
