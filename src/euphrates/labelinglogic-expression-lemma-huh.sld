
(define-library
  (euphrates labelinglogic-expression-lemma-huh)
  (export labelinglogic:expression:lemma?)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-atom-huh)
          labelinglogic:expression:atom?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          let
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-lemma-huh.scm")))
    (else (include
            "labelinglogic-expression-lemma-huh.scm"))))
