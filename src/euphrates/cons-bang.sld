
(define-library
  (euphrates cons-bang)
  (export cons!)
  (import
    (only (scheme base)
          _
          begin
          cons
          define-syntax
          set!
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/cons-bang.scm")))
    (else (include "cons-bang.scm"))))
