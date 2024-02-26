
(define-library
  (euphrates olgraph-transitive-closure)
  (export olgraph-transitive-closure)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import
    (only (euphrates olgraph) olnode:children))
  (import
    (only (scheme base)
          begin
          cons
          define
          for-each
          lambda
          let
          list
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-transitive-closure.scm")))
    (else (include "olgraph-transitive-closure.scm"))))
