
(define-library
  (euphrates labelinglogic-citizen-tuple)
  (export
    labelinglogic:citizen:tuple:make
    labelinglogic:citizen:tuple?
    labelinglogic:citizen:members)
  (import
    (only (scheme base)
          <
          and
          apply
          begin
          cdr
          cons
          define
          equal?
          quote
          vector
          vector->list
          vector-length
          vector-ref
          vector?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-citizen-tuple.scm")))
    (else (include "labelinglogic-citizen-tuple.scm"))))
