
(define-library
  (euphrates define-dumb-record)
  (export define-dumb-record)
  (import
    (only (scheme base)
          _
          begin
          cond-expand
          define-record-type
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/define-dumb-record.scm")))
    (else (include "define-dumb-record.scm"))))
