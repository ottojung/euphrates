
(define-library
  (euphrates list-take-until)
  (export list-take-until)
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (scheme base)
          begin
          cons
          define
          if
          let
          list
          null?
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-take-until.scm")))
    (else (include "list-take-until.scm"))))
