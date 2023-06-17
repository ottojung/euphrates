
(define-library
  (euphrates profun-op-apply)
  (export
    profun-op-apply
    profun-apply-return!
    profun-apply-fail!)
  (import
    (only (euphrates box)
          box-ref
          box-set!
          box?
          make-box))
  (import
    (only (euphrates profun-accept)
          profun-ctx-set
          profun-set))
  (import
    (only (euphrates profun-op-apply-result-p)
          profun-op-apply/result/p))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (euphrates profun-reject) profun-reject))
  (import
    (only (euphrates profun-value)
          profun-bound-value?))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          +
          <=
          apply
          begin
          car
          case
          cdr
          define
          else
          equal?
          if
          length
          let
          list-ref
          null?
          or
          parameterize
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-apply.scm")))
    (else (include "profun-op-apply.scm"))))
