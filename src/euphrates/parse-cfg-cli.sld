
(define-library
  (euphrates parse-cfg-cli)
  (export CFG-CLI->CFG-AST)
  (import
    (only (euphrates list-split-on) list-split-on)
    (only (euphrates raisu) raisu)
    (only (euphrates tilda-a) ~a)
    (only (scheme base)
          /
          begin
          car
          cdr
          cons
          define
          equal?
          if
          lambda
          let
          list
          list?
          map
          null?
          or
          quote
          unless
          when)
    (only (srfi srfi-1) last)
    (only (srfi srfi-42) :))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/parse-cfg-cli.scm")))
    (else (include "parse-cfg-cli.scm"))))
