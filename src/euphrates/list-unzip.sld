
(define-library
  (euphrates list-unzip)
  (export list-unzip)
  (import
    (only (scheme base)
          begin
          caar
          cdar
          cdr
          cons
          define
          define-values
          if
          let
          null?
          quote
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-unzip.scm")))
    (else (include "list-unzip.scm"))))
