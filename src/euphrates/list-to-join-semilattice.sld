
(define-library
  (euphrates list-to-join-semilattice)
  (export list->join-semilattice)
  (import (only (euphrates debug) debug))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates hashset)
          hashset-clear!
          make-hashset))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates olgraph-remove-transitive-edges)
          olgraph-remove-transitive-edges))
  (import
    (only (euphrates olgraph-reverse-children-inplace-bang)
          olgraph-reverse-children-inplace!))
  (import
    (only (euphrates olgraph)
          make-olgraph
          make-olnode
          olnode:children
          olnode:meta
          olnode:meta:set!
          olnode:prepend-child!
          olnode:value))
  (import
    (only (euphrates olnode-eq-huh) olnode-eq?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          +
          =
          _
          and
          begin
          call-with-values
          car
          cdr
          cons
          define
          if
          lambda
          length
          let
          list
          map
          null?
          number?
          or
          quote
          set!
          unless
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-to-join-semilattice.scm")))
    (else (include "list-to-join-semilattice.scm"))))
