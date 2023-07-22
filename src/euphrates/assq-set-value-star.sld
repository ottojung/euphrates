
(define-library
  (euphrates assq-set-value-star)
  (export assq-set-value*)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates assq-set-value) assq-set-value))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          cond-expand
          define
          else
          if
          let
          let*
          list?
          null?
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/assq-set-value-star.scm")))
    (else (include "assq-set-value-star.scm"))))
