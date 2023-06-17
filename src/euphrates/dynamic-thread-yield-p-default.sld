
(define-library
  (euphrates dynamic-thread-yield-p-default)
  (export dynamic-thread-yield/p-default)
  (import
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-yield-p-default.scm")))
    (else (include "dynamic-thread-yield-p-default.scm"))))
