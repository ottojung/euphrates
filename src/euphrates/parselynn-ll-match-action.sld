
(define-library
  (euphrates parselynn-ll-match-action)
  (export
    parselynn:ll-match-action:make
    parselynn:ll-match-action?
    parselynn:ll-match-action:symbol)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-match-action.scm")))
    (else (include "parselynn-ll-match-action.scm"))))
