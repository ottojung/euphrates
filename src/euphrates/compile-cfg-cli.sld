
(define-library
  (euphrates compile-cfg-cli)
  (export
    CFG-AST->CFG-lang
    CFG-CLI->CFG-lang
    CFG-lang-modifier-char?)
  (import
    (only (euphrates compose) compose)
    (only (euphrates hashset)
          hashset-has?
          make-hashset)
    (only (euphrates identity) identity)
    (only (euphrates parse-cfg-cli) CFG-CLI->CFG-AST)
    (only (euphrates raisu) raisu)
    (only (euphrates tilda-a) ~a)
    (only (srfi srfi-13)
          string-prefix?
          string-suffix?)
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
          values)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/compile-cfg-cli.scm")))
    (else (include "compile-cfg-cli.scm"))))
