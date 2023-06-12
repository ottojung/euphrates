
(define-library
  (euphrates define-newtype)
  (export define-newtype)
  (import
    (only (euphrates define-type9)
          define-type9/nobind-descriptor)
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/define-newtype.scm")))
    (else (include "define-newtype.scm"))))
