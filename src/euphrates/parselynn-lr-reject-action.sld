
(define-library
  (euphrates parselynn-lr-reject-action)
  (export
    parselynn:lr-reject-action:make
    parselynn:lr-reject-action?)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-reject-action.scm")))
    (else (include "parselynn-lr-reject-action.scm"))))
