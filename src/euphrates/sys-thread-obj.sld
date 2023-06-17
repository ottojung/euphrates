
(define-library
  (euphrates sys-thread-obj)
  (export
    sys-thread-obj
    sys-thread-obj?
    sys-thread-obj-handle
    set-sys-thread-obj-handle!
    sys-thread-obj-cancel-scheduled?
    set-sys-thread-obj-cancel-scheduled?!
    sys-thread-obj-cancel-enabled?
    set-sys-thread-obj-cancel-enabled?!)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/sys-thread-obj.scm")))
    (else (include "sys-thread-obj.scm"))))
