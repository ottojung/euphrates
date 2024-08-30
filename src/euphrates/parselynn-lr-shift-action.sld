
(define-library
  (euphrates parselynn-lr-shift-action)
  (export
    parselynn:lr-shift-action:make
    parselynn:lr-shift-action?
    parselynn:lr-shift-action:source-id
    parselynn:lr-shift-action:source-state
    parselynn:lr-shift-action:target-id
    parselynn:lr-shift-action:target-state)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-shift-action.scm")))
    (else (include "parselynn-lr-shift-action.scm"))))
