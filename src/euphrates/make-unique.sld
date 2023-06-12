
(define-library
  (euphrates make-unique)
  (export make-unique)
  (import
    (only (scheme base)
          begin
          define
          eq?
          lambda
          let
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/make-unique.scm")))
    (else (include "make-unique.scm"))))
