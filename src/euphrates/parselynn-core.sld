
(define-library
  (euphrates parselynn-core)
  (export parselynn:core)
  (import (only (euphrates assoc-or) assoc-or))
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates bnf-alist-map-grouped-productions)
          bnf-alist:map-grouped-productions))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import (only (euphrates fkeyword) fkeyword?))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates iterator) iterator:make))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-take-n) list-take-n))
  (import
    (only (euphrates
            parselynn-core-conflict-handler-default)
          parselynn:core:conflict-handler/default))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates parselynn-core-output-table-port-p)
          parselynn:core:output-table-port/p))
  (import
    (only (euphrates parselynn-core-struct)
          make-parselynn:core:struct))
  (import
    (only (euphrates
            parselynn-default-compilation-environment)
          parselynn:default-compilation-environment))
  (import
    (only (euphrates parselynn-lr-action-print)
          parselynn:lr-action:print))
  (import
    (only (euphrates parselynn-lr-compute-parsing-table)
          parselynn:lr-compute-parsing-table))
  (import
    (only (euphrates parselynn-lr-interpret)
          parselynn:lr-interpret))
  (import
    (only (euphrates
            parselynn-lr-parsing-table-get-conflicts)
          parselynn:lr-parsing-table:get-conflicts))
  (import
    (only (euphrates parselynn-lr-reduce-action)
          parselynn:lr-reduce-action?))
  (import
    (only (euphrates parselynn-lr-reject-action)
          parselynn:lr-reject-action?))
  (import
    (only (euphrates parselynn-lr-shift-action)
          parselynn:lr-shift-action?))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:typetag))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
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
  (import (only (scheme eval) eval))
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
