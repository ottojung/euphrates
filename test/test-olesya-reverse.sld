
(define-library
  (test-olesya-reverse)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates olesya-reverse) olesya:reverse))
  (import
    (only (scheme base)
          begin
          define
          equal?
          let
          list
          map
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-olesya-reverse.scm")))
    (else (include "test-olesya-reverse.scm"))))
