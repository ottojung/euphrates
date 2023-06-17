
(define-library
  (euphrates printf)
  (export printf)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates dynamic-thread-spawn-p)
          dynamic-thread-spawn/p))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates uni-spinlock)
          make-uni-spinlock-critical))
  (import
    (only (scheme base)
          apply
          begin
          cons
          define
          if
          lambda
          let
          set!
          when))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-28) format)))
    (else (import (only (srfi 28) format))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/printf.scm")))
    (else (include "printf.scm"))))
