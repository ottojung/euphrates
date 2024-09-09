
(define-library
  (euphrates parselynn-lr-1-compile-for-core)
  (export parselynn:lr-1-compile/for-core)
  (import
    (only (euphrates iterator) iterator:next))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-lr-parsing-table-compile)
          parselynn:lr-parsing-table:compile))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:state:initial))
  (import
    (only (euphrates parselynn-lr-reject-action)
          parselynn:lr-reject-action:make
          parselynn:lr-reject-action?))
  (import
    (only (euphrates parselynn-lr-shift-action)
          parselynn:lr-shift-action:target-id))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:category
          parselynn:token:source
          parselynn:token:value))
  (import
    (only (euphrates stack)
          stack-make
          stack-peek
          stack-push!))
  (import
    (only (scheme base)
          _
          begin
          define
          define-syntax
          define-values
          equal?
          if
          let
          quasiquote
          quote
          syntax-rules
          unquote
          values
          vector-ref))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-1-compile-for-core.scm")))
    (else (include "parselynn-lr-1-compile-for-core.scm"))))
