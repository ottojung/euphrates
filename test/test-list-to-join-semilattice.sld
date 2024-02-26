
(define-library
  (test-list-to-join-semilattice)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates greatest-common-divisor)
          greatest-common-divisor))
  (import
    (only (euphrates list-to-join-semilattice)
          list->join-semilattice))
  (import
    (only (euphrates olgraph-to-list) olnode->list))
  (import
    (only (euphrates olgraph) olgraph:initial))
  (import
    (only (scheme base)
          begin
          define
          equal?
          lambda
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-to-join-semilattice.scm")))
    (else (include "test-list-to-join-semilattice.scm"))))
