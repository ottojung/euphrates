
(define-library
  (euphrates parselynn-ll-1-compile-for-core)
  (export parselynn:ll-1-compile/for-core)
  (import
    (only (euphrates iterator) iterator:next))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates
            parselynn-ll-compile-get-predictor-name)
          parselynn:ll-compile:get-predictor-name))
  (import
    (only (euphrates parselynn-ll-parsing-table-compile)
          parselynn:ll-parsing-table:compile))
  (import
    (only (euphrates parselynn-ll-parsing-table)
          parselynn:ll-parsing-table:clauses
          parselynn:ll-parsing-table:starting-nonterminal))
  (import
    (only (euphrates parselynn-ll-reject-action)
          parselynn:ll-reject-action:make
          parselynn:ll-reject-action?))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:category
          parselynn:token:source
          parselynn:token:value))
  (import
    (only (scheme base)
          _
          and
          begin
          define
          define-syntax
          equal?
          error
          error-object-irritants
          error-object?
          guard
          if
          lambda
          null?
          quasiquote
          quote
          set!
          syntax-rules
          unquote
          unquote-splicing
          vector-ref))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-1-compile-for-core.scm")))
    (else (include "parselynn-ll-1-compile-for-core.scm"))))
