
(define-library
  (euphrates monadobj)
  (export
    monadobj-constructor
    monadobj?
    monadobj-procedure
    monadobj-uses-continuations?
    monadobj-handles-fin?)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monadobj.scm")))
    (else (include "monadobj.scm"))))
