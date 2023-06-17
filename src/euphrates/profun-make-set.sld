
(define-library
  (euphrates profun-make-set)
  (export profun-make-set)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result))
  (import
    (only (euphrates profun-accept)
          profun-ctx-set
          profun-set))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (euphrates profun-reject) profun-reject))
  (import
    (only (euphrates profun-value)
          profun-bound-value?))
  (import
    (only (scheme base)
          _
          begin
          car
          cdr
          define-syntax
          if
          let
          member
          not
          null?
          or
          set!
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-make-set.scm")))
    (else (include "profun-make-set.scm"))))
