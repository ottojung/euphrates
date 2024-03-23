
(define-library
  (euphrates labelinglogic-expression-infinite-huh)
  (export labelinglogic:expression:infinite?)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic:expression:constants))
  (import
    (only (euphrates labelinglogic-expression-desugar)
          labelinglogic:expression:desugar))
  (import
    (only (euphrates
            labelinglogic-expression-move-nots-down)
          labelinglogic:expression:move-nots-down))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          define
          equal?
          list
          not
          or
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-infinite-huh.scm")))
    (else (include
            "labelinglogic-expression-infinite-huh.scm"))))
