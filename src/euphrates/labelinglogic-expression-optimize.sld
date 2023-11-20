
(define-library
  (euphrates labelinglogic-expression-optimize)
  (export labelinglogic:expression:optimize)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates
            labelinglogic-expression-move-nots-down)
          labelinglogic:expression:move-nots-down))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates list-group-by) list-group-by))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
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
          cons
          define
          else
          equal?
          if
          lambda
          length
          let
          list
          map
          member
          not
          null?
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize.scm")))
    (else (include "labelinglogic-expression-optimize.scm"))))
