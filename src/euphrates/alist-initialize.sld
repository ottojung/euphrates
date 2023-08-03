
(define-library
  (euphrates alist-initialize)
  (export alist-initialize)
  (import
    (only (euphrates alist-initialize-bang)
          alist-initialize!))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          let
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alist-initialize.scm")))
    (else (include "alist-initialize.scm"))))
