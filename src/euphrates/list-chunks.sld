
(define-library
  (euphrates list-chunks)
  (export list-chunks)
  (import
    (only (euphrates list-span-n) list-span-n))
  (import
    (only (scheme base)
          _
          begin
          call-with-values
          cons
          define
          if
          lambda
          let
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-chunks.scm")))
    (else (include "list-chunks.scm"))))
