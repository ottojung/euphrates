
(define-library
  (euphrates serialization-short)
  (export serialize/short deserialize/short)
  (import
    (only (euphrates assoc-or) assoc-or)
    (only (euphrates const) const)
    (only (euphrates descriptors-registry)
          descriptors-registry-get)
    (only (euphrates raisu) raisu)
    (only (euphrates serialization-sexp-short)
          deserialize/sexp/short
          serialize/sexp/short)
    (only (euphrates string-drop-n) string-drop-n)
    (only (srfi srfi-13) string-prefix?)
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
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/serialization-short.scm")))
    (else (include "serialization-short.scm"))))
