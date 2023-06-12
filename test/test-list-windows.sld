
(define-library
  (test-list-windows)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates comp) comp)
    (only (euphrates list-windows) list-windows)
    (only (scheme base) + apply begin let map quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-windows.scm")))
    (else (include "test-list-windows.scm"))))
