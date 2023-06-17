
(define-library
  (euphrates dynamic-thread-async-thunk)
  (export dynamic-thread-async-thunk)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates dynamic-thread-mutex-lock)
          dynamic-thread-mutex-lock!))
  (import
    (only (euphrates dynamic-thread-mutex-make)
          dynamic-thread-mutex-make))
  (import
    (only (euphrates dynamic-thread-mutex-unlock)
          dynamic-thread-mutex-unlock!))
  (import
    (only (euphrates dynamic-thread-spawn)
          dynamic-thread-spawn))
  (import (only (euphrates raisu) raisu))
  (import
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
          when))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-async-thunk.scm")))
    (else (include "dynamic-thread-async-thunk.scm"))))
