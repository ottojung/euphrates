
(define-library
  (euphrates lesya-compile-to-olesya)
  (export lesya:compile/->olesya)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-compile-to-olesya.scm")))
    (else (include "lesya-compile-to-olesya.scm"))))
