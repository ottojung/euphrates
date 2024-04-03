
(define-library
  (test-list-to-join-semilattice)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates greatest-common-divisor)
          greatest-common-divisor))
  (import
    (only (euphrates hashset)
          hashset-equal?
          list->hashset))
  (import
    (only (euphrates list-intersect) list-intersect))
  (import
    (only (euphrates list-to-join-semilattice)
          list->join-semilattice))
  (import (only (euphrates list-union) list-union))
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
          if
          lambda
          let
          min
          null?
          quote
          syntax-rules
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-to-join-semilattice.scm")))
    (else (include "test-list-to-join-semilattice.scm"))))
