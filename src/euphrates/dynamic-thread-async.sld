
(define-library
  (euphrates dynamic-thread-async)
  (export dynamic-thread-async)
  (import
    (only (euphrates dynamic-thread-async-thunk)
          dynamic-thread-async-thunk))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-async.scm")))
    (else (include "dynamic-thread-async.scm"))))
