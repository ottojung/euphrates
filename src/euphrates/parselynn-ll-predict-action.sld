
(define-library
  (euphrates parselynn-ll-predict-action)
  (export
    parselynn:ll-predict-action:make
    parselynn:ll-predict-action?
    parselynn:ll-predict-action:nonterminal)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-predict-action.scm")))
    (else (include "parselynn-ll-predict-action.scm"))))
