
(define-library
  (euphrates
    labelinglogic-make-nondet-descriminator)
  (export labelinglogic:make-nondet-descriminator)
  (import
    (only (euphrates labelinglogic-model-evaluate)
          labelinglogic:model:evaluate))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-make-nondet-descriminator.scm")))
    (else (include
            "labelinglogic-make-nondet-descriminator.scm"))))
