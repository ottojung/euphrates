
(define-library
  (euphrates sys-usleep)
  (export sys-usleep)
  (import
    (only (scheme base) / begin cond-expand define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) usleep))
           (begin
             (include-from-path "euphrates/sys-usleep.scm")))
    (else (include "sys-usleep.scm"))))
