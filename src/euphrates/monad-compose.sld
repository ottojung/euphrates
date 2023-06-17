
(define-library
  (euphrates monad-compose)
  (export monad-compose)
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates monadobj)
          monadobj-constructor
          monadobj-handles-fin?
          monadobj-procedure
          monadobj-uses-continuations?
          monadobj?))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base) begin define or quote unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monad-compose.scm")))
    (else (include "monad-compose.scm"))))
