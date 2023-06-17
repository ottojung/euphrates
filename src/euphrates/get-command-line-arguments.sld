
(define-library
  (euphrates get-command-line-arguments)
  (export get-command-line-arguments)
  (import
    (only (euphrates command-line-arguments-p)
          command-line-argumets/p))
  (import
    (only (scheme base)
          <
          _
          begin
          cdr
          cond-expand
          define
          if
          lambda
          length
          let
          or
          quote
          vector->list))
  (import
    (only (scheme process-context) command-line))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/get-command-line-arguments.scm")))
    (else (include "get-command-line-arguments.scm"))))
