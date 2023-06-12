
(define-library
  (euphrates monad-make-no-cont-no-fin)
  (export monad-make/no-cont/no-fin)
  (import
    (only (euphrates monadfinobj) monadfinobj?)
    (only (euphrates monadobj) monadobj-constructor)
    (only (scheme base) begin define if lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/monad-make-no-cont-no-fin.scm")))
    (else (include "monad-make-no-cont-no-fin.scm"))))
