
(define-library
  (euphrates rtree)
  (export
    rtree
    rtree?
    rtree-ref
    set-rtree-ref!
    rtree-value
    rtree-children
    set-rtree-children!)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/rtree.scm")))
    (else (include "rtree.scm"))))
