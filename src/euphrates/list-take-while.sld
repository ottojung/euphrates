
(define-library
  (euphrates list-take-while)
  (export list-take-while)
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (scheme base)
          begin
          cons
          define
          if
          let
          null?
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-take-while.scm")))
    (else (include "list-take-while.scm"))))
