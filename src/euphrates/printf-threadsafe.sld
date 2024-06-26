
(define-library
  (euphrates printf-threadsafe)
  (export printf/threadsafe)
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates printf) printf))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates uni-spinlock)
          make-uni-spinlock-critical))
  (import
    (only (scheme base)
          _
          apply
          begin
          cons
          define
          lambda
          let
          set!
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/printf-threadsafe.scm")))
    (else (include "printf-threadsafe.scm"))))
