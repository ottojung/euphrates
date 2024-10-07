
(define-library
  (test-olesya-trace+interpret)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates olesya-trace+interpret)
          olesya:trace+interpret
          olesya:traced-object:trace
          olesya:traced-object:value))
  (import
    (only (scheme base)
          =
          begin
          define
          equal?
          if
          map
          quote
          unless))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-olesya-trace+interpret.scm")))
    (else (include "test-olesya-trace+interpret.scm"))))
