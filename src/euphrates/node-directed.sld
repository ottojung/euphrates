
(define-library
  (euphrates node-directed)
  (export make-node/directed)
  (import
    (only (euphrates node-directed-obj)
          node/directed))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/node-directed.scm")))
    (else (include "node-directed.scm"))))
