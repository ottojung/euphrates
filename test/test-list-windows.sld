
(define-library
  (test-list-windows)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates list-windows) list-windows))
  (import
    (only (scheme base)
          +
          apply
          begin
          cond-expand
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-windows.scm")))
    (else (include "test-list-windows.scm"))))
