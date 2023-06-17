
(define-library
  (euphrates profun-RFC)
  (export
    make-profun-RFC
    profun-RFC?
    profun-RFC-what
    profun-RFC-set-iter
    profun-RFC-modify-iter
    profun-RFC-add-info
    profun-RFC-insert
    profun-RFC-reset)
  (import
    (only (euphrates profun-abort)
          make-profun-abort
          profun-abort-add-info
          profun-abort-modify-iter
          profun-abort-set-iter
          profun-abort-type
          profun-abort-what
          profun-abort?))
  (import
    (only (euphrates profun-iterator)
          profun-abort-insert
          profun-abort-reset))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-RFC.scm")))
    (else (include "profun-RFC.scm"))))
