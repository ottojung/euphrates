
(define-library
  (euphrates labelinglogic-citizen-r7rs)
  (export
    labelinglogic:citizen:r7rs:make
    labelinglogic:citizen:r7rs?
    labelinglogic:citizen:r7rs:code)
  (import
    (only (scheme base)
          =
          and
          begin
          define
          equal?
          quote
          vector
          vector-length
          vector-ref
          vector?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-citizen-r7rs.scm")))
    (else (include "labelinglogic-citizen-r7rs.scm"))))
