
(define-library
  (euphrates parselynn-lr-accept-action)
  (export
    parselynn:lr-accept-action:make
    parselynn:lr-accept-action?)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-accept-action.scm")))
    (else (include "parselynn-lr-accept-action.scm"))))
