
(define-library
  (euphrates labelinglogic-expression-atom-huh)
  (export labelinglogic:expression:atom?)
  (import
    (only (euphrates labelinglogic-expression-bottom-huh)
          labelinglogic:expression:bottom?))
  (import
    (only (euphrates labelinglogic-expression-top-huh)
          labelinglogic:expression:top?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          =
          begin
          define
          equal?
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-atom-huh.scm")))
    (else (include "labelinglogic-expression-atom-huh.scm"))))
