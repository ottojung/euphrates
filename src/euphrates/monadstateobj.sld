
(define-library
  (euphrates monadstateobj)
  (export
    monadstateobj
    monadstateobj?
    monadstateobj-lval
    monadstateobj-cont
    monadstateobj-qvar
    monadstateobj-qval
    monadstateobj-qtags)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monadstateobj.scm")))
    (else (include "monadstateobj.scm"))))
