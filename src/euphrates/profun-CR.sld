
(define-library
  (euphrates profun-CR)
  (export make-profun-CR profun-CR? profun-CR-what)
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
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-CR.scm")))
    (else (include "profun-CR.scm"))))
