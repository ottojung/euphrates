
(define-library
  (euphrates labelinglogic-interpret-r7rs-code)
  (export labelinglogic:interpret-r7rs-code)
  (import
    (only (scheme base)
          begin
          define
          lambda
          let
          quote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-interpret-r7rs-code.scm")))
    (else (include "labelinglogic-interpret-r7rs-code.scm"))))
