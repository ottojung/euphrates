
(define-library
  (euphrates petri-net-obj)
  (export
    petri-net-obj
    petri-net-obj?
    petri-net-obj-transitions
    petri-net-obj-queue
    petri-net-obj-critical
    petri-net-obj-finished?
    set-petri-net-obj-finished?!)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/petri-net-obj.scm")))
    (else (include "petri-net-obj.scm"))))
