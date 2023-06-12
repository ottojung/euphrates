
(define-library
  (euphrates petri-net-make)
  (export petri-net-make)
  (import
    (only (euphrates dynamic-thread-critical-make)
          dynamic-thread-critical-make)
    (only (euphrates petri-net-obj) petri-net-obj)
    (only (euphrates stack) stack-make)
    (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/petri-net-make.scm")))
    (else (include "petri-net-make.scm"))))
