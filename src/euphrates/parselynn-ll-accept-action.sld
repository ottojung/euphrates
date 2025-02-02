
(define-library
  (euphrates parselynn-ll-accept-action)
  (export
    parselynn:ll-accept-action:make
    parselynn:ll-accept-action?)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-accept-action.scm")))
    (else (include "parselynn-ll-accept-action.scm"))))
