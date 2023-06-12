
(define-library
  (euphrates monad-compose)
  (export monad-compose)
  (import
    (only (euphrates compose) compose)
    (only (euphrates monadobj)
          monadobj-constructor
          monadobj-handles-fin?
          monadobj-procedure
          monadobj-uses-continuations?
          monadobj?)
    (only (euphrates raisu) raisu)
    (only (scheme base) begin define or quote unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monad-compose.scm")))
    (else (include "monad-compose.scm"))))
