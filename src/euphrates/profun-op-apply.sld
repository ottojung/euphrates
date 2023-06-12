
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
          make-box)
    (only (euphrates profun-accept)
          profun-ctx-set
          profun-set)
    (only (euphrates profun-op-apply-result-p)
          #{profun-op-apply/result#p}#)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-value)
          profun-bound-value?)
    (only (euphrates raisu) raisu)
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
