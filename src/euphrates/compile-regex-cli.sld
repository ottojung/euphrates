
(define-library
  (euphrates compile-regex-cli)
  (export
    compile-regex-cli:make-IR
    compile-regex-cli:IR->Regex)
  (import (only (euphrates compose) compose))
  (import (only (euphrates const) const))
  (import
    (only (euphrates group-by-sequential)
          group-by/sequential*))
  (import (only (euphrates list-init) list-init))
  (import (only (euphrates raisu) raisu))
  (import
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
          unquote-splicing))
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
               "euphrates/compile-regex-cli.scm")))
    (else (include "compile-regex-cli.scm"))))
