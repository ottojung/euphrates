
(define-library
  (euphrates get-current-program-path)
  (export get-current-program-path)
  (import
    (only (euphrates current-program-path-p)
          current-program-path/p))
  (import
    (only (scheme base)
          begin
          car
          cond-expand
          define
          if
          let
          null?
          or
          quote))
  (import
    (only (scheme process-context) command-line))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/get-current-program-path.scm")))
    (else (include "get-current-program-path.scm"))))
