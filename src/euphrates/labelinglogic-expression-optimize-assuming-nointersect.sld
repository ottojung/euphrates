
(define-library
  (euphrates
    labelinglogic-expression-optimize-assuming-nointersect)
  (export
    labelinglogic:expression:optimize/assuming-nointersect)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-and-assuming-nointersect)
          labelinglogic:expression:optimize/and-assuming-nointersect))
  (import
    (only (euphrates labelinglogic-expression-to-dnf)
          labelinglogic:expression:to-dnf))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (scheme base)
          begin
          car
          define
          equal?
          if
          map
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-expression-optimize-assuming-nointersect.scm"))))
