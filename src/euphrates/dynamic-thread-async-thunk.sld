
(define-library
  (euphrates dynamic-thread-async-thunk)
  (export dynamic-thread-async-thunk)
  (import
    (only (euphrates catch-any) catch-any)
    (only (euphrates dynamic-thread-mutex-lock)
          dynamic-thread-mutex-lock!)
    (only (euphrates dynamic-thread-mutex-make)
          dynamic-thread-mutex-make)
    (only (euphrates dynamic-thread-mutex-unlock)
          dynamic-thread-mutex-unlock!)
    (only (euphrates dynamic-thread-spawn)
          dynamic-thread-spawn)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          apply
          begin
          call-with-values
          case
          define
          eq?
          lambda
          quote
          set!
          values
          when)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-async-thunk.scm")))
    (else (include "dynamic-thread-async-thunk.scm"))))
