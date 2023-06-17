
(define-library
  (euphrates serialization-short)
  (export serialize/short deserialize/short)
  (import (only (euphrates assoc-or) assoc-or))
  (import (only (euphrates const) const))
  (import
    (only (euphrates descriptors-registry)
          descriptors-registry-get))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates serialization-sexp-short)
          deserialize/sexp/short
          serialize/sexp/short))
  (import
    (only (euphrates string-drop-n) string-drop-n))
  (import
    (only (scheme base)
          and
          apply
          assoc
          begin
          car
          cdr
          cons
          define
          equal?
          lambda
          length
          let*
          list
          list-ref
          list?
          map
          not
          null?
          or
          quote
          string->symbol
          string-append
          symbol->string
          symbol?
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/serialization-short.scm")))
    (else (include "serialization-short.scm"))))
