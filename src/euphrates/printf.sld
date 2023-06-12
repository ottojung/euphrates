
(define-library
  (euphrates printf)
  (export printf)
  (import
    (only (euphrates catch-any) catch-any)
    (only (euphrates dynamic-thread-spawn-p)
          #{dynamic-thread-spawn#p}#)
    (only (euphrates raisu) raisu)
    (only (euphrates uni-spinlock)
          make-uni-spinlock-critical)
    (only (scheme base)
          apply
          begin
          cons
          define
          if
          lambda
          let
          set!
          when)
    (only (scheme write) display)
    (only (srfi srfi-28) format))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/printf.scm")))
    (else (include "printf.scm"))))
