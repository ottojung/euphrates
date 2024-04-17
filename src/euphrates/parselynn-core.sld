
(define-library
  (euphrates parselynn-core)
  (export
    parselynn:core
    make-lexical-token
    serialized-parser-typetag
    lexical-token?
    lexical-token-category
    lexical-token-value
    lexical-token-source)
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates fkeyword) fkeyword?))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates parselynn-core-load-from-disk)
          parselynn:core:load-from-disk))
  (import
    (only (euphrates parselynn-core-load)
          parselynn:core:load))
  (import
    (only (euphrates parselynn-core-serialized-typetag)
          parselynn:core:serialized-typetag))
  (import
    (only (euphrates parselynn-core-struct)
          make-parselynn:core:struct
          parselynn:core:struct:code))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
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
  (import
    (only (scheme file)
          call-with-output-file
          file-exists?))
  (import (only (scheme write) display write))
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
