
(define-library
  (euphrates profun-IDR)
  (export
    make-profun-IDR
    profun-IDR?
    profun-IDR-name
    profun-IDR-arity)
  (import
    (only (euphrates profun-abort)
          make-profun-abort
          profun-abort-type
          profun-abort-what
          profun-abort?))
  (import
    (only (scheme base)
          and
          begin
          cadr
          car
          define
          equal?
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-IDR.scm")))
    (else (include "profun-IDR.scm"))))
