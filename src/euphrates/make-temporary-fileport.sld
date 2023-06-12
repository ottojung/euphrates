
(define-library
  (euphrates make-temporary-fileport)
  (export make-temporary-fileport)
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let
          string-copy
          values)
    (only (srfi srfi-60) logand))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (except (guile) cond-expand))
           (begin
             (include-from-path
               "euphrates/make-temporary-fileport.scm")))
    (else (include "make-temporary-fileport.scm"))))
