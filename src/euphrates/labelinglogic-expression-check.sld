
(define-library
  (euphrates labelinglogic-expression-check)
  (export labelinglogic::expression::check)
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          begin
          car
          cdr
          cond
          define
          else
          equal?
          let
          list
          list?
          or
          quote
          symbol?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-check.scm")))
    (else (include "labelinglogic-expression-check.scm"))))
