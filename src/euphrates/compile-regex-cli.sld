
(define-library
  (euphrates compile-regex-cli)
  (export
    compile-regex-cli:make-IR
    compile-regex-cli:IR->Regex)
  (import
    (only (euphrates compose) compose)
    (only (euphrates const) const)
    (only (euphrates group-by-sequential)
          group-by/sequential*)
    (only (euphrates list-init) list-init)
    (only (euphrates raisu) raisu)
    (only (srfi srfi-13)
          string-prefix?
          string-suffix?)
    (only (scheme base)
          *
          =
          and
          assoc
          begin
          cadr
          car
          case
          cddr
          cdr
          cond
          cons
          define
          else
          equal?
          if
          lambda
          let
          list->string
          list?
          map
          not
          null?
          or
          pair?
          quasiquote
          quote
          string->list
          symbol->string
          unquote
          unquote-splicing)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/compile-regex-cli.scm")))
    (else (include "compile-regex-cli.scm"))))
