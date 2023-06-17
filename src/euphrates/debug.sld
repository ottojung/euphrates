
(define-library
  (euphrates debug)
  (export debug)
  (import (only (euphrates conss) conss))
  (import
    (only (euphrates global-debug-mode-filter)
          global-debug-mode-filter))
  (import (only (euphrates printf) printf))
  (import
    (only (scheme base)
          apply
          begin
          current-error-port
          current-output-port
          define
          let
          not
          or
          parameterize
          string-append
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/debug.scm")))
    (else (include "debug.scm"))))
