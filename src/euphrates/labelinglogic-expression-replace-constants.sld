
(define-library
  (euphrates
    labelinglogic-expression-replace-constants)
  (export
    labelinglogic:expression:replace-constants)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic:expression:check))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (scheme base)
          =
          begin
          cond
          define
          else
          equal?
          if
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-replace-constants.scm")))
    (else (include
            "labelinglogic-expression-replace-constants.scm"))))
