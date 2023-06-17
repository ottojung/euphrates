
(define-library
  (euphrates system-environment-get-all)
  (export system-environment-get-all)
  (import
    (only (euphrates string-drop-n) string-drop-n))
  (import
    (only (euphrates string-split-simple)
          string-split/simple))
  (import
    (only (scheme base)
          +
          begin
          car
          cond-expand
          cons
          define
          map
          string-length))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) environ))
           (begin
             (include-from-path
               "euphrates/system-environment-get-all.scm")))
    (else (include "system-environment-get-all.scm"))))
