
(define-library
  (euphrates printf)
  (export printf)
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base) apply begin cons define))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/printf.scm")))
    (else (include "printf.scm"))))
