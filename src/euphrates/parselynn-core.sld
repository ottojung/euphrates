
(define-library
  (euphrates parselynn-core)
  (export parselynn:core)
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates fkeyword) fkeyword?))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates
            parselynn-core-conflict-handler-default)
          parselynn:core:conflict-handler/default))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates parselynn-core-struct)
          make-parselynn:core:struct))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:typetag))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          <=
          =
          =>
          >
          >=
          _
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
          current-output-port
          define
          define-values
          do
          else
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
          parameterize
          port?
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
             (include-from-path
               "euphrates/parselynn-core.scm")))
    (else (include "parselynn-core.scm"))))
