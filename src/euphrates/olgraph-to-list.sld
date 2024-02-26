
(define-library
  (euphrates olgraph-to-list)
  (export olgraph->list)
  (import
    (only (euphrates olgraph)
          olnode:children
          olnode:value))
  (import
    (only (scheme base)
          begin
          cons
          define
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-to-list.scm")))
    (else (include "olgraph-to-list.scm"))))