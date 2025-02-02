
(define-library
  (euphrates parselynn-ll-reject-action)
  (export
    parselynn:ll-reject-action:make
    parselynn:ll-reject-action?)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-reject-action.scm")))
    (else (include "parselynn-ll-reject-action.scm"))))
