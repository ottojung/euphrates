
(define-library
  (euphrates assq-set-default)
  (export assq-set-default)
  (import
    (only (euphrates assq-set-value) assq-set-value)
    (only (scheme base)
          _
          assq
          begin
          define
          define-syntax
          if
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/assq-set-default.scm")))
    (else (include "assq-set-default.scm"))))
