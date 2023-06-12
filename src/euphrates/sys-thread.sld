
(define-library
  (euphrates sys-thread)
  (export
    sys-thread-cancel
    sys-thread-current
    sys-thread-disable-cancel
    sys-thread-enable-cancel
    sys-thread-mutex-make
    sys-thread-mutex-lock!
    sys-thread-mutex-unlock!
    sys-thread-spawn
    sys-thread-sleep)
  (import
    (only (euphrates dynamic-thread-cancel-tag)
          dynamic-thread-cancel-tag)
    (only (euphrates raisu) raisu)
    (only (euphrates sys-mutex-lock) sys-mutex-lock!)
    (only (euphrates sys-mutex-make) sys-mutex-make)
    (only (euphrates sys-mutex-unlock)
          sys-mutex-unlock!)
    (only (euphrates sys-thread-current-p-default)
          #{sys-thread-current#p-default}#)
    (only (euphrates sys-thread-current-p)
          #{sys-thread-current#p}#)
    (only (euphrates sys-thread-obj)
          set-sys-thread-obj-cancel-enabled?!
          set-sys-thread-obj-cancel-scheduled?!
          set-sys-thread-obj-handle!
          sys-thread-obj
          sys-thread-obj-cancel-enabled?
          sys-thread-obj-cancel-scheduled?)
    (only (euphrates sys-usleep) sys-usleep)
    (only (scheme base)
          and
          begin
          cond-expand
          define
          let
          or
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (ice-9 threads))
           (begin
             (include-from-path "euphrates/sys-thread.scm")))
    (else (include "sys-thread.scm"))))
