
(define-library
  (euphrates olgraph-reverse-children-inplace-bang)
  (export olgraph-reverse-children-inplace!)
  (import
    (only (euphrates olgraph-reverse-children)
          olgraph-reverse-children))
  (import
    (only (euphrates olgraph)
          olgraph:initial
          olnode:children
          olnode:children:set!))
  (import
    (only (scheme base)
          begin
          define
          for-each
          let
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-reverse-children-inplace-bang.scm")))
    (else (include
            "olgraph-reverse-children-inplace-bang.scm"))))
