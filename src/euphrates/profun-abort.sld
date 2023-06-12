
(define-library
  (euphrates profun-abort)
  (export
    make-profun-abort
    profun-abort?
    profun-abort-type
    profun-abort-iter
    profun-abort-what
    profun-abort-additional
    profun-abort-set-iter
    profun-abort-modify-iter
    profun-abort-add-info)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base)
          append
          apply
          begin
          define
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-abort.scm")))
    (else (include "profun-abort.scm"))))
