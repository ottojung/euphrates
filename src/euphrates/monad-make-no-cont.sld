
(define-library
  (euphrates monad-make-no-cont)
  (export monad-make/no-cont)
  (import
    (only (euphrates monadobj) monadobj-constructor)
    (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/monad-make-no-cont.scm")))
    (else (include "monad-make-no-cont.scm"))))
