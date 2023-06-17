
(define-library
  (euphrates asyncproc)
  (export
    asyncproc
    asyncproc?
    asyncproc-command
    asyncproc-args
    asyncproc-pipe
    set-asyncproc-pipe!
    asyncproc-pid
    set-asyncproc-pid!
    asyncproc-status
    set-asyncproc-status!
    asyncproc-exited?
    set-asyncproc-exited?!)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/asyncproc.scm")))
    (else (include "asyncproc.scm"))))
