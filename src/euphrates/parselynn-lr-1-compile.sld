
(define-library
  (euphrates parselynn-lr-1-compile)
  (export parselynn:lr-1-compile)
  (import
    (only (euphrates parselynn-lr-1-compile-for-core)
          parselynn:lr-1-compile/for-core))
  (import
    (only (scheme base)
          begin
          define
          lambda
          let
          quasiquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-1-compile.scm")))
    (else (include "parselynn-lr-1-compile.scm"))))
