
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
          make-box)
    (only (euphrates profun-accept)
          profun-ctx-set
          profun-set)
    (only (euphrates profun-op-eval-result-p)
          #{profun-op-eval/result#p}#)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates raisu) raisu)
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
