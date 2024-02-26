
(define-library
  (euphrates list-to-join-semilattice)
  (export list->join-semilattice)
  (import
    (only (euphrates olgraph)
          make-olgraph
          make-olnode))
  (import
    (only (scheme base)
          begin
          define
          lambda
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-to-join-semilattice.scm")))
    (else (include "list-to-join-semilattice.scm"))))
