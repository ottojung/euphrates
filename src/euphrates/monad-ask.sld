
(define-library
  (euphrates monad-ask)
  (export monad-ask)
  (import
    (only (euphrates catchu-case) catchu-case)
    (only (euphrates monad-do) monad-do/generic)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          <
          >
          _
          begin
          cond
          define
          define-syntax
          else
          if
          let
          list
          quote
          syntax-rules
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monad-ask.scm")))
    (else (include "monad-ask.scm"))))
