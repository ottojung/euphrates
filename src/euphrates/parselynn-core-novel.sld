
(define-library
  (euphrates parselynn-core-novel)
  (export parselynn:core:novel)
  (import
    (only (euphrates bnf-alist-map-grouped-productions)
          bnf-alist:map-grouped-productions))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import
    (only (euphrates list-take-n) list-take-n))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates
            parselynn-core-driver-normalized-name-to-type-alist)
          parselynn:core:driver-normalized-name->type/alist))
  (import
    (only (euphrates parselynn-core-grammar-error)
          parselynn:core:grammar-error))
  (import
    (only (euphrates parselynn-core-signal-lr-conflict)
          parselynn:core:signal-lr-conflict))
  (import
    (only (euphrates parselynn-ll-1-compile-for-core)
          parselynn:ll-1-compile/for-core))
  (import
    (only (euphrates parselynn-ll-compute-parsing-table)
          parselynn:ll-compute-parsing-table))
  (import
    (only (euphrates
            parselynn-ll-parsing-table-get-conflicts)
          parselynn:ll-parsing-table:get-conflicts))
  (import
    (only (euphrates parselynn-lr-1-compile-for-core)
          parselynn:lr-1-compile/for-core))
  (import
    (only (euphrates parselynn-lr-action-print)
          parselynn:lr-action:print))
  (import
    (only (euphrates parselynn-lr-compute-parsing-table)
          parselynn:lr-compute-parsing-table))
  (import
    (only (euphrates
            parselynn-lr-parsing-table-get-conflicts)
          parselynn:lr-parsing-table:get-conflicts))
  (import
    (only (euphrates parselynn-lr-reduce-action)
          parselynn:lr-reduce-action?))
  (import
    (only (euphrates parselynn-lr-shift-action)
          parselynn:lr-shift-action?))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          _
          apply
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          for-each
          if
          lambda
          let
          list
          map
          null?
          parameterize
          quasiquote
          quote
          string->symbol
          string-append
          unless
          unquote-splicing
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-novel.scm")))
    (else (include "parselynn-core-novel.scm"))))
