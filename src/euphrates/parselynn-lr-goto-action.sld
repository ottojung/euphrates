
(define-library
  (euphrates parselynn-lr-goto-action)
  (export
    parselynn:lr-goto-action:make
    parselynn:lr-goto-action?
    parselynn:lr-goto-action:source-id
    parselynn:lr-goto-action:source-state
    parselynn:lr-goto-action:target-id
    parselynn:lr-goto-action:target-state)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-goto-action.scm")))
    (else (include "parselynn-lr-goto-action.scm"))))
