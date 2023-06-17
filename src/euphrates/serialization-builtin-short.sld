
(define-library
  (euphrates serialization-builtin-short)
  (export
    serialize-builtin/short
    deserialize-builtin/short)
  (import
    (only (euphrates atomic-box)
          atomic-box-ref
          atomic-box?
          make-atomic-box))
  (import
    (only (euphrates box) box-ref box? make-box))
  (import
    (only (euphrates builtin-type-huh) builtin-type?))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          and
          apply
          begin
          cadr
          car
          case
          cdr
          cond
          cond-expand
          cons
          define
          else
          if
          lambda
          list?
          make-parameter
          map
          not
          null?
          pair?
          quasiquote
          quote
          symbol->string
          symbol?
          unquote
          vector
          vector->list
          vector?))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (only (guile)
                   parameter?
                   hash-table?
                   hash-map->list)
             (only (ice-9 hash-table) alist->hash-table))
           (import (only (guile) hash-table?))
           (begin
             (include-from-path
               "euphrates/serialization-builtin-short.scm")))
    (else (include "serialization-builtin-short.scm"))))
