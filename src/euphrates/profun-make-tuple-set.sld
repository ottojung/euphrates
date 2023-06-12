
(define-library
  (euphrates profun-make-tuple-set)
  (export profun-make-tuple-set)
  (import
    (only (euphrates profun-accept)
          profun-accept
          profun-ctx-set
          profun-set)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-value)
          profun-unbound-value?)
    (only (scheme base)
          +
          _
          and
          begin
          car
          case
          cdr
          define
          define-syntax
          else
          equal?
          if
          let
          list
          list-ref
          null?
          or
          set!
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-make-tuple-set.scm")))
    (else (include "profun-make-tuple-set.scm"))))
