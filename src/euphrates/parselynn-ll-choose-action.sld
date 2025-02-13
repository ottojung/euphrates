
(define-library
  (euphrates parselynn-ll-choose-action)
  (export
    parselynn:ll-choose-action
    parselynn:ll-choose-action?
    parselynn:ll-choose-action:make
    parselynn:ll-choose-action:production)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-choose-action.scm")))
    (else (include "parselynn-ll-choose-action.scm"))))
