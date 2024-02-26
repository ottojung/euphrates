
(define-library
  (euphrates olgraph)
  (export
    make-olgraph
    olgraph:children
    olgraph:children:set!
    olgraph:eq?
    olgraph:meta)
  (import
    (only (scheme base)
          +
          begin
          define
          define-record-type
          lambda
          let
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph.scm")))
    (else (include "olgraph.scm"))))
