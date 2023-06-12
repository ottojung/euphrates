
(define-library
  (euphrates monadstate)
  (export
    monadstate?
    monadstate-cret
    monadstate-cret/thunk
    monadstate-ret
    monadstate-ret/thunk
    monadstate-make-empty
    monadstate-qvar
    monadstate-qval
    monadstate-qtags
    monadstate-lval
    monadstate-arg
    monadstate-args
    monadstate-replicate-multiple
    monadstate-handle-multiple)
  (import
    (only (euphrates identity-star) identity*)
    (only (euphrates memconst) memconst)
    (only (euphrates monadfinobj)
          monadfinobj
          monadfinobj-lval
          monadfinobj?)
    (only (euphrates monadstate-current-p)
          monadstate-current/p)
    (only (euphrates monadstateobj)
          monadstateobj
          monadstateobj-cont
          monadstateobj-lval
          monadstateobj-qtags
          monadstateobj-qval
          monadstateobj-qvar
          monadstateobj?)
    (only (euphrates raisu) raisu)
    (only (euphrates replicate) replicate)
    (only (scheme base)
          <
          _
          apply
          begin
          call-with-values
          define
          define-syntax
          if
          lambda
          length
          let*
          list?
          quote
          syntax-rules
          unless
          values)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monadstate.scm")))
    (else (include "monadstate.scm"))))
