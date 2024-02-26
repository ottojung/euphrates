
(define-library
  (euphrates list-to-join-semilattice)
  (export list->join-semilattice)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-to-join-semilattice.scm")))
    (else (include "list-to-join-semilattice.scm"))))
