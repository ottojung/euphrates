
(define-library
  (euphrates monad-ask)
  (export monad-ask)
  (import
    (only (euphrates catchu-case) catchu-case))
  (import
    (only (euphrates monad-do) monad-do/generic))
  (import (only (euphrates raisu) raisu))
  (import
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
