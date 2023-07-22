
(define-library
  (euphrates assq-or-star)
  (export assq-or*)
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          assq
          begin
          car
          cdr
          cond
          cond-expand
          define-syntax
          else
          if
          let
          let*
          null?
          pair?
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assq-or-star.scm")))
    (else (include "assq-or-star.scm"))))
