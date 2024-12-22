
(define-library
  (euphrates lesya-object-to-olesya-object)
  (export lesya-object->olesya-object)
  (import
    (only (euphrates lesya-syntax)
          lesya:syntax:implication:destruct
          lesya:syntax:implication?))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:rule:make
          olesya:syntax:term:make))
  (import
    (only (scheme base)
          begin
          define
          define-values
          if
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-object-to-olesya-object.scm")))
    (else (include "lesya-object-to-olesya-object.scm"))))
