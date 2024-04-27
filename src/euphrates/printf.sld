
(define-library
  (euphrates printf)
  (export printf)
  (import (only (euphrates fprintf) fprintf))
  (import
    (only (scheme base)
          apply
          begin
          cons
          current-output-port
          define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/printf.scm")))
    (else (include "printf.scm"))))
