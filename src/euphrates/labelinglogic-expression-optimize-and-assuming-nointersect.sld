
(define-library
  (euphrates
    labelinglogic-expression-optimize-and-assuming-nointersect)
  (export
    labelinglogic:expression:optimize/and-assuming-nointersect)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          list
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize-and-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-expression-optimize-and-assuming-nointersect.scm"))))
