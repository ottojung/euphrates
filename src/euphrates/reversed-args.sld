
(define-library
  (euphrates reversed-args)
  (export reversed-args)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/reversed-args.scm")))
    (else (include "reversed-args.scm"))))
