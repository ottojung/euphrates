
(define-library
  (euphrates np-thread-obj)
  (export
    np-thread-obj
    np-thread-obj?
    np-thread-obj-continuation
    set-np-thread-obj-continuation!
    np-thread-obj-cancel-scheduled?
    set-np-thread-obj-cancel-scheduled?!
    np-thread-obj-cancel-enabled?
    set-np-thread-obj-cancel-enabled?!)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/np-thread-obj.scm")))
    (else (include "np-thread-obj.scm"))))
