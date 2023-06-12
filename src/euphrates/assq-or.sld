
(define-library
  (euphrates assq-or)
  (export assq-or)
  (import
    (only (scheme base)
          _
          assq
          begin
          cdr
          define-syntax
          if
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assq-or.scm")))
    (else (include "assq-or.scm"))))
