
(define-library
  (euphrates shell-quote)
  (export shell-quote shell-quote/always/list)
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates shell-safe-alphabet)
          shell-safe/alphabet/index))
  (import
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
          string->list))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/shell-quote.scm")))
    (else (include "shell-quote.scm"))))
