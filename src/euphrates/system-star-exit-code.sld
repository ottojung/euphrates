
(define-library
  (euphrates system-star-exit-code)
  (export system*/exit-code)
  (import
    (only (scheme base)
          apply
          begin
          cond-expand
          define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) system*))
           (import (only (guile) status:exit-val))
           (begin
             (include-from-path
               "euphrates/system-star-exit-code.scm")))
    (else (include "system-star-exit-code.scm"))))
