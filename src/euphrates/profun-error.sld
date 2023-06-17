
(define-library
  (euphrates profun-error)
  (export
    make-profun-error
    profun-error?
    profun-error-args)
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
          define
          equal?
          error
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-error.scm")))
    (else (include "profun-error.scm"))))
