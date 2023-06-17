
(define-library
  (euphrates run-asyncproc-p-default)
  (export run-asyncproc/p-default)
  (import
    (only (euphrates asyncproc-input-text-p)
          asyncproc-input-text/p))
  (import
    (only (euphrates asyncproc-stderr)
          asyncproc-stderr))
  (import
    (only (euphrates asyncproc-stdout)
          asyncproc-stdout))
  (import
    (only (euphrates asyncproc)
          asyncproc
          asyncproc-args
          asyncproc-command
          set-asyncproc-exited?!
          set-asyncproc-pid!
          set-asyncproc-pipe!
          set-asyncproc-status!))
  (import
    (only (euphrates call-with-finally)
          call-with-finally))
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates conss) conss))
  (import
    (only (euphrates dynamic-thread-get-delay-procedure)
          dynamic-thread-get-delay-procedure))
  (import
    (only (euphrates dynamic-thread-spawn)
          dynamic-thread-spawn))
  (import
    (only (euphrates file-delete) file-delete))
  (import
    (only (euphrates make-temporary-fileport)
          make-temporary-fileport))
  (import
    (only (euphrates read-string-file)
          read-string-file))
  (import
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
          when))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (ice-9 popen))
           (import (except (guile) cond-expand))
           (begin
             (include-from-path
               "euphrates/run-asyncproc-p-default.scm")))
    (else (include "run-asyncproc-p-default.scm"))))
