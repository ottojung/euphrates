
(define-library
  (euphrates dynamic-thread-spawn-p)
  (export #{dynamic-thread-spawn#p}#)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-spawn-p.scm")))
    (else (include "dynamic-thread-spawn-p.scm"))))
