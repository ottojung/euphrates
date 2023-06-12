
(define-library
  (euphrates monadfinobj)
  (export
    monadfinobj
    monadfinobj?
    monadfinobj-lval)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monadfinobj.scm")))
    (else (include "monadfinobj.scm"))))
