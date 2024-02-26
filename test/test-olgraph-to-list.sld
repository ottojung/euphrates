
(define-library
  (test-olgraph-to-list)
  (import
    (only (euphrates olgraph-to-list) olnode->list))
  (import
    (only (euphrates olgraph)
          make-olgraph
          make-olnode
          olgraph:initial
          olgraph:prepend-initial!
          olnode:prepend-child!))
  (import
    (only (scheme base) begin define let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-olgraph-to-list.scm")))
    (else (include "test-olgraph-to-list.scm"))))
