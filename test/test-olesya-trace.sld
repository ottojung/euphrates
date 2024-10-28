
(define-library
  (test-olesya-trace)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates olesya-interpret)
          olesya:interpret:eval))
  (import
    (only (euphrates olesya-trace)
          olesya:trace
          olesya:trace:with-callback))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          =
          begin
          define
          equal?
          if
          lambda
          let
          list
          map
          quote
          reverse
          unless))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-olesya-trace.scm")))
    (else (include "test-olesya-trace.scm"))))
