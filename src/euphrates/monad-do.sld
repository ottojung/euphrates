
(define-library
  (euphrates monad-do)
  (export monad-do monad-do/generic)
  (import (only (euphrates memconst) memconst))
  (import
    (only (euphrates monad-apply) monad-apply))
  (import
    (only (euphrates monad-current-p)
          monad-current/p))
  (import (only (euphrates monadobj) monadobj?))
  (import
    (only (euphrates monadstateobj)
          monadstateobj
          monadstateobj-cont
          monadstateobj-lval
          monadstateobj-qvar))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          =
          _
          apply
          begin
          call-with-current-continuation
          call-with-values
          cond
          define
          define-syntax
          else
          equal?
          if
          lambda
          length
          let
          let*
          list
          list-ref
          list?
          map
          not
          procedure?
          quote
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monad-do.scm")))
    (else (include "monad-do.scm"))))
