
(define-library
  (euphrates
    labelinglogic-make-nondet-descriminator)
  (export labelinglogic:make-nondet-descriminator)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates labelinglogic-expression-evaluate)
          labelinglogic:expression:evaluate))
  (import
    (only (scheme base) and begin define lambda map))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-make-nondet-descriminator.scm")))
    (else (include
            "labelinglogic-make-nondet-descriminator.scm"))))
