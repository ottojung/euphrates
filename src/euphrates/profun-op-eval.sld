
(define-library
  (euphrates profun-op-eval)
  (export
    profun-op-eval
    profun-eval-return!
    profun-eval-fail!)
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
    (only (euphrates profun-op-eval-result-p)
          #{profun-op-eval/result#p}#))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (euphrates profun-reject) profun-reject))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          apply
          begin
          cadr
          car
          cddr
          cdr
          define
          equal?
          if
          let
          null?
          or
          parameterize
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-eval.scm")))
    (else (include "profun-op-eval.scm"))))
