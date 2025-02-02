
(define-library
  (euphrates parselynn-ll-1-compile)
  (export parselynn:ll-1-compile)
  (import
    (only (euphrates parselynn-ll-1-compile-for-core)
          parselynn:ll-1-compile/for-core))
  (import
    (only (scheme base)
          begin
          define
          let
          quasiquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-1-compile.scm")))
    (else (include "parselynn-ll-1-compile.scm"))))
