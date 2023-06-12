
(define-library
  (euphrates dynamic-load)
  (export dynamic-load)
  (import
    (only (scheme base) begin define)
    (only (scheme load) load))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/dynamic-load.scm")))
    (else (include "dynamic-load.scm"))))
