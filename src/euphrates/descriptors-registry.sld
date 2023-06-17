
(define-library
  (euphrates descriptors-registry)
  (export
    descriptors-registry-get
    descriptors-registry-add!
    descriptors-registry-decolisify-name)
  (import
    (only (euphrates builtin-descriptors)
          builtin-descriptors))
  (import
    (only (euphrates hashmap)
          hashmap-count
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          +
          =
          >
          and
          assoc
          begin
          cdr
          cons
          define
          for-each
          if
          lambda
          let
          list?
          number->string
          pair?
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
               "euphrates/descriptors-registry.scm")))
    (else (include "descriptors-registry.scm"))))
