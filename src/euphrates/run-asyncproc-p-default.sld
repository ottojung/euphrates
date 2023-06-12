
(define-library
  (euphrates run-asyncproc-p-default)
  (export run-asyncproc/p-default)
  (import
    (only (euphrates asyncproc-input-text-p)
          asyncproc-input-text/p)
    (only (euphrates asyncproc-stderr)
          asyncproc-stderr)
    (only (euphrates asyncproc-stdout)
          asyncproc-stdout)
    (only (euphrates asyncproc)
          asyncproc
          asyncproc-args
          asyncproc-command
          set-asyncproc-exited?!
          set-asyncproc-pid!
          set-asyncproc-pipe!
          set-asyncproc-status!)
    (only (euphrates call-with-finally)
          call-with-finally)
    (only (euphrates catch-any) catch-any)
    (only (euphrates conss) conss)
    (only (euphrates dynamic-thread-get-delay-procedure)
          dynamic-thread-get-delay-procedure)
    (only (euphrates dynamic-thread-spawn)
          dynamic-thread-spawn)
    (only (euphrates file-delete) file-delete)
    (only (euphrates make-temporary-fileport)
          make-temporary-fileport)
    (only (euphrates read-string-file)
          read-string-file)
    (only (scheme base)
          _
          apply
          begin
          car
          case
          cdr
          close-port
          cond-expand
          current-error-port
          current-output-port
          define
          define-syntax
          define-values
          else
          if
          lambda
          let
          let*
          or
          parameterize
          quote
          set!
          syntax-rules
          values
          when)
    (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (ice-9 popen))
           (import (except (guile) cond-expand))
           (begin
             (include-from-path
               "euphrates/run-asyncproc-p-default.scm")))
    (else (include "run-asyncproc-p-default.scm"))))
