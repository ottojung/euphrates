
(define-library
  (euphrates monad-apply)
  (export monad-apply)
  (import
    (only (euphrates monadobj) monadobj-procedure))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monad-apply.scm")))
    (else (include "monad-apply.scm"))))
