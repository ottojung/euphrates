
(define-library
  (euphrates lesya-interpret)
  (export lesya:interpret)
  (import
    (only (euphrates lesya-language)
          lesya:language:alpha
          lesya:language:and
          lesya:language:apply
          lesya:language:axiom
          lesya:language:begin
          lesya:language:beta
          lesya:language:define
          lesya:language:lambda
          lesya:language:run))
  (import
    (only (scheme base)
          and
          apply
          begin
          define
          lambda
          quote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-interpret.scm")))
    (else (include "lesya-interpret.scm"))))
