
(define-library
  (euphrates dynamic-thread-mutex-make-p)
  (export dynamic-thread-mutex-make/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-make-p.scm")))
    (else (include "dynamic-thread-mutex-make-p.scm"))))
