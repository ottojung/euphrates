
(define-library
  (euphrates lalr-parser)
  (export
    lalr-parser
    make-source-location
    source-location?
    source-location-line
    source-location-column
    make-lexical-token
    lexical-token?
    lexical-token-category
    lexical-token-value
    lexical-token-source)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates gkeyword)
          gkeyword->fkeyword
          gkeyword?))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (euphrates pretty-print) pretty-print))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
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
          cons
          define
          define-values
          do
          else
          eq?
          equal?
          error
          expt
          for-each
          if
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
          procedure?
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
          unless
          unquote
          unquote-splicing
          values
          vector
          vector->list
          vector-length
          vector-map
          vector-ref
          vector-set!
          vector?
          when))
  (import (only (scheme cxr) caaar cadar caddr))
  (import (only (scheme eval) environment eval))
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
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/lalr-parser.scm")))
    (else (include "lalr-parser.scm"))))
