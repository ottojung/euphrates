
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
    (only (euphrates identity-star) identity*))
  (import (only (euphrates memconst) memconst))
  (import
    (only (euphrates monadfinobj)
          monadfinobj
          monadfinobj-lval
          monadfinobj?))
  (import
    (only (euphrates monadstate-current-p)
          monadstate-current/p))
  (import
    (only (euphrates monadstateobj)
          monadstateobj
          monadstateobj-cont
          monadstateobj-lval
          monadstateobj-qtags
          monadstateobj-qval
          monadstateobj-qvar
          monadstateobj?))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates replicate) replicate))
  (import
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
          values))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monadstate.scm")))
    (else (include "monadstate.scm"))))
