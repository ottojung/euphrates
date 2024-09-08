
(define-library
  (euphrates iterator)
  (export iterator:make iterator? iterator:next)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          _
          begin
          define
          define-syntax
          define-values
          equal?
          if
          lambda
          let
          list
          or
          procedure?
          quote
          syntax-rules
          unless
          values
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/iterator.scm")))
    (else (include "iterator.scm"))))
