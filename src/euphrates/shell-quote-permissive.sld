
(define-library
  (euphrates shell-quote-permissive)
  (export shell-quote/permissive)
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates shell-nondisrupt-alphabet)
          shell-nondisrupt/alphabet/index))
  (import
    (only (euphrates shell-quote)
          shell-quote/always/list))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          null?
          string->list))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/shell-quote-permissive.scm")))
    (else (include "shell-quote-permissive.scm"))))
