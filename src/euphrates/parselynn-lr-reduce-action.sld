
(define-library
  (euphrates parselynn-lr-reduce-action)
  (export
    parselynn:lr-reduce-action:make
    parselynn:lr-reduce-action?
    parselynn:lr-reduce-action:production)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-reduce-action.scm")))
    (else (include "parselynn-lr-reduce-action.scm"))))
