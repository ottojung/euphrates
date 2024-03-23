
(define-library
  (euphrates
    labelinglogic-expression-equal-huh-and-assuming-nointersect)
  (export
    labelinglogic:expression:equal?/and-assuming-nointersect)
  (import
    (only (euphrates hashset)
          hashset-equal?
          list->hashset))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-equal-huh-and-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-expression-equal-huh-and-assuming-nointersect.scm"))))
