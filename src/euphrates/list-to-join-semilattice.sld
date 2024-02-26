
(define-library
  (euphrates list-to-join-semilattice)
  (export list->join-semilattice)
  (import
    (only (euphrates cartesian-each) cartesian-each))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (euphrates olgraph)
          make-olgraph
          make-olnode
          olnode:id
          olnode:value))
  (import
    (only (scheme base)
          <
          begin
          define
          equal?
          lambda
          length
          let
          map
          quote
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-to-join-semilattice.scm")))
    (else (include "list-to-join-semilattice.scm"))))
