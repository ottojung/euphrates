
(define-library
  (euphrates reversed-args-f)
  (export reversed-args-f)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/reversed-args-f.scm")))
    (else (include "reversed-args-f.scm"))))
