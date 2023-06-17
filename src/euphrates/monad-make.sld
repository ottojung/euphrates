
(define-library
  (euphrates monad-make)
  (export monad-make)
  (import
    (only (euphrates monadobj) monadobj-constructor))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monad-make.scm")))
    (else (include "monad-make.scm"))))
