
(define-library
  (euphrates node-directed-obj)
  (export
    node/directed
    node/directed?
    node/directed-children
    set-node/directed-children!
    node/directed-label
    set-node/directed-label!)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/node-directed-obj.scm")))
    (else (include "node-directed-obj.scm"))))
