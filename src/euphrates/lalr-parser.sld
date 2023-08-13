
(define-library
  (euphrates lalr-parser)
  (export lalr-parser)
  (import
    (only (scheme base)
          *
          +
          -
          <
          <=
          =
          =>
          >
          >=
          and
          append
          apply
          assoc
          assq
          assv
          begin
          caar
          cadr
          car
          case
          cdar
          cddr
          cdr
          cond
          cond-expand
          cons
          define
          define-record-type
          do
          else
          eq?
          equal?
          error
          expt
          for-each
          if
          integer?
          lambda
          length
          let
          let*
          list
          list->vector
          list-ref
          list?
          make-vector
          map
          max
          member
          memq
          modulo
          newline
          not
          null?
          number->string
          number?
          or
          pair?
          quasiquote
          quote
          quotient
          remainder
          reverse
          set!
          set-car!
          set-cdr!
          string->symbol
          string-append
          string?
          symbol->string
          symbol?
          unquote
          unquote-splicing
          vector
          vector->list
          vector-length
          vector-map
          vector-ref
          vector-set!
          vector?))
  (import (only (scheme cxr) caaar cadar caddr))
  (import (only (scheme file) with-output-to-file))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import
             (only (srfi srfi-1)
                   count
                   drop
                   first
                   last
                   reduce
                   take-right)))
    (else (import
            (only (srfi 1)
                  count
                  drop
                  first
                  last
                  reduce
                  take-right))))
  (cond-expand
    (guile (import (only (srfi srfi-171) rcount)))
    (else (import (only (srfi 171) rcount))))
  (cond-expand
    (guile (import (only (srfi srfi-37) option)))
    (else (import (only (srfi 37) option))))
  (cond-expand
    (guile (import (only (srfi srfi-60) logior)))
    (else (import (only (srfi 60) logior))))
  (cond-expand
    (guile (import (only (srfi srfi-88) keyword?)))
    (else (import (only (srfi 88) keyword?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) define-macro))
           (import (only (ice-9 pretty-print) pretty-print))
           (import (srfi srfi-9))
           (begin
             (include-from-path "euphrates/lalr-parser.scm")))
    (else (include "lalr-parser.scm"))))
