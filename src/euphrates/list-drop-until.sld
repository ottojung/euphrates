
(define-library
  (euphrates list-drop-until)
  (export list-drop-until)
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (scheme base)
          begin
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
               "euphrates/list-drop-until.scm")))
    (else (include "list-drop-until.scm"))))
