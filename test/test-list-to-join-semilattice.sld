
(define-library
  (test-list-to-join-semilattice)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates list-to-join-semilattice)
          list->join-semilattice))
  (import
    (only (euphrates olgraph-to-adjlist)
          olgraph->adjlist))
  (import
    (only (scheme base)
          +
          _
          begin
          define
          define-syntax
          equal?
          lambda
          let
          min
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-to-join-semilattice.scm")))
    (else (include "test-list-to-join-semilattice.scm"))))
