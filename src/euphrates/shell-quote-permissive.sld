
(define-library
  (euphrates shell-quote-permissive)
  (export shell-quote/permissive)
  (import
    (only (euphrates negate) negate)
    (only (euphrates shell-nondisrupt-alphabet)
          shell-nondisrupt/alphabet/index)
    (only (euphrates shell-quote)
          shell-quote/always/list)
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          null?
          string->list)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/shell-quote-permissive.scm")))
    (else (include "shell-quote-permissive.scm"))))
