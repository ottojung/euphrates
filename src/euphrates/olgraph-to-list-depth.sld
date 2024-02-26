
(define-library
  (euphrates olgraph-to-list-depth)
  (export olgraph->list/depth)
  (import
    (only (euphrates olgraph)
          olnode:children
          olnode:value))
  (import
    (only (scheme base)
          +
          >
          begin
          cons
          define
          if
          lambda
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-to-list-depth.scm")))
    (else (include "olgraph-to-list-depth.scm"))))
