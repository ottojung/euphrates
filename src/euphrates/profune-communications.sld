
(define-library
  (euphrates profune-communications)
  (export profune-communications)
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (euphrates profun) profun-eval-query))
  (import
    (only (euphrates profune-communications-hook-p)
          profune-communications-hook/p))
  (import
    (only (euphrates profune-communicator)
          profune-communicator-db
          profune-communicator-handle))
  (import
    (only (scheme base)
          _
          and
          begin
          cadr
          car
          cdr
          cond
          define
          else
          equal?
          error
          if
          lambda
          let
          let*
          not
          null?
          or
          pair?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profune-communications.scm")))
    (else (include "profune-communications.scm"))))
