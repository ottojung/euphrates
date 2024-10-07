
(define-library
  (test-olesya-trace)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates olesya-trace) olesya:trace))
  (import
    (only (scheme base)
          =
          begin
          define
          equal?
          if
          list
          map
          quote
          unless))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-olesya-trace.scm")))
    (else (include "test-olesya-trace.scm"))))
