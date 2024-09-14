
(define-library
  (euphrates lesya-interpret)
  (export lesya:interpret)
  (import
    (only (euphrates lesya-language)
          lesya:language:apply
          lesya:language:axiom
          lesya:language:begin
          lesya:language:define
          lesya:language:lambda
          lesya:language:run
          lesya:language:set!))
  (import
    (only (scheme base)
          apply
          begin
          define
          lambda
          quote
          set!))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-interpret.scm")))
    (else (include "lesya-interpret.scm"))))
