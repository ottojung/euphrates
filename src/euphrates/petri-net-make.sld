
(define-library
  (euphrates petri-net-make)
  (export petri-net-make)
  (import
    (only (euphrates dynamic-thread-critical-make)
          dynamic-thread-critical-make))
  (import
    (only (euphrates petri-net-obj) petri-net-obj))
  (import (only (euphrates stack) stack-make))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/petri-net-make.scm")))
    (else (include "petri-net-make.scm"))))
