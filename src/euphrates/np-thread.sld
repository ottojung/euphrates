
(define-library
  (euphrates np-thread)
  (export
    np-thread-make-env
    np-thread-global-spawn
    np-thread-global-cancel
    np-thread-global-disable-cancel
    np-thread-global-enable-cancel
    np-thread-global-yield
    np-thread-global-sleep
    np-thread-global-mutex-make
    np-thread-global-mutex-lock!
    np-thread-global-mutex-unlock!
    np-thread-global-critical-make)
  (import
    (only (euphrates box) box-ref box-set! make-box)
    (only (euphrates dynamic-thread-cancel-tag)
          dynamic-thread-cancel-tag)
    (only (euphrates dynamic-thread-get-wait-delay)
          dynamic-thread-get-wait-delay)
    (only (euphrates fn) fn)
    (only (euphrates np-thread-obj)
          np-thread-obj
          np-thread-obj-cancel-enabled?
          np-thread-obj-cancel-scheduled?
          np-thread-obj-continuation
          np-thread-obj?
          set-np-thread-obj-cancel-enabled?!
          set-np-thread-obj-cancel-scheduled?!
          set-np-thread-obj-continuation!)
    (only (euphrates queue)
          make-queue
          queue-pop!
          queue-push!)
    (only (euphrates raisu) raisu)
    (only (euphrates sys-usleep) sys-usleep)
    (only (euphrates
            time-get-monotonic-nanoseconds-timestamp)
          time-get-monotonic-nanoseconds-timestamp)
    (only (euphrates unit-conversions)
          micro->nano/unit
          nano->micro/unit)
    (only (euphrates with-critical) with-critical)
    (only (scheme base)
          +
          -
          >
          and
          begin
          call-with-current-continuation
          define
          define-values
          eq?
          if
          lambda
          let
          let*
          min
          not
          quote
          set!
          unless
          values
          when)
    (only (srfi srfi-18) current-thread))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/np-thread.scm")))
    (else (include "np-thread.scm"))))
