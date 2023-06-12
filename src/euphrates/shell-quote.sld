
(define-library
  (euphrates shell-quote)
  (export shell-quote shell-quote/always/list)
  (import
    (only (euphrates negate) negate)
    (only (euphrates shell-safe-alphabet)
          shell-safe/alphabet/index)
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          equal?
          if
          let
          list->string
          null?
          quote
          string->list)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/shell-quote.scm")))
    (else (include "shell-quote.scm"))))
