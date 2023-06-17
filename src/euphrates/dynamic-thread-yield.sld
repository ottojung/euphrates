
(define-library
  (euphrates dynamic-thread-yield)
  (export dynamic-thread-yield)
  (import
    (only (euphrates dynamic-thread-yield-p-default)
          #{dynamic-thread-yield#p-default}#))
  (import
    (only (euphrates dynamic-thread-yield-p)
          #{dynamic-thread-yield#p}#))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-yield.scm")))
    (else (include "dynamic-thread-yield.scm"))))
