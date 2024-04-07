
(define-library
  (euphrates olgraph-reverse-children)
  (export olgraph-reverse-children)
  (import
    (only (euphrates olgraph-copy)
          olgraph-copy/deep
          olnode-copy/deep))
  (import
    (only (euphrates olgraph-reverse-children-inplace-bang)
          olgraph-reverse-children-inplace!
          olnode-reverse-children-inplace!))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-reverse-children.scm")))
    (else (include "olgraph-reverse-children.scm"))))
