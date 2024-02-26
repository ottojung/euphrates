
(define-library
  (euphrates list-to-join-semilattice)
  (export list->join-semilattice)
  (import
    (only (euphrates cartesian-each) cartesian-each))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates olgraph)
          make-olgraph
          make-olnode
          olnode:children
          olnode:id
          olnode:prepend-child!
          olnode:value))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          <
          _
          begin
          call-with-values
          car
          cdr
          cons
          define
          equal?
          lambda
          length
          let
          list
          map
          null?
          or
          quote
          set!
          unless
          values
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-to-join-semilattice.scm")))
    (else (include "list-to-join-semilattice.scm"))))
