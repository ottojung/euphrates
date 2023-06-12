
(define-library
  (euphrates dynamic-thread-critical-make)
  (export dynamic-thread-critical-make)
  (import
    (only (euphrates
            dynamic-thread-critical-make-p-default)
          #{dynamic-thread-critical-make#p-default}#)
    (only (euphrates dynamic-thread-critical-make-p)
          #{dynamic-thread-critical-make#p}#)
    (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-critical-make.scm")))
    (else (include "dynamic-thread-critical-make.scm"))))
