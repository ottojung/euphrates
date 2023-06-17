
(define-library
  (euphrates profun-state)
  (export
    profun-state-constructor
    profun-state?
    profun-state-current
    profun-state-stack
    profun-state-failstate
    profun-state-undo
    profun-state-make
    profun-state-build
    set-profun-state-current
    profun-state-final?
    profun-state-finish)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates profun-instruction)
          profun-instruction-build))
  (import
    (only (scheme base) begin define list not quote))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-state.scm")))
    (else (include "profun-state.scm"))))
