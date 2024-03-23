
(define-library
  (euphrates labelinglogic-expression-infinite-huh)
  (export labelinglogic:expression:infinite?)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          and
          begin
          car
          cond
          define
          else
          equal?
          let
          list
          member
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-infinite-huh.scm")))
    (else (include
            "labelinglogic-expression-infinite-huh.scm"))))
