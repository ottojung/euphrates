
(define-library
  (euphrates serialization-builtin-natural)
  (export
    serialize-builtin/natural
    deserialize-builtin/natural)
  (import
    (only (euphrates atomic-box)
          atomic-box-ref
          atomic-box?
          make-atomic-box))
  (import
    (only (euphrates box) box-ref box? make-box))
  (import
    (only (euphrates make-error-object)
          make-error-object))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          apply
          begin
          cadr
          car
          case
          cdr
          char?
          cond
          cond-expand
          cons
          define
          else
          eof-object?
          equal?
          error-object-irritants
          error-object-message
          error-object?
          lambda
          list
          list?
          make-parameter
          map
          number?
          pair?
          quasiquote
          quote
          string?
          symbol?
          unquote
          unquote-splicing
          vector
          vector?
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme cxr) caddr))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (only (guile)
                   parameter?
                   hash-table?
                   hash-map->list)
             (only (ice-9 hash-table) alist->hash-table))
           (begin
             (include-from-path
               "euphrates/serialization-builtin-natural.scm")))
    (else (include "serialization-builtin-natural.scm"))))
