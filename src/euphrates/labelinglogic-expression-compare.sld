
(define-library
  (euphrates labelinglogic-expression-compare)
  (export labelinglogic:expression:compare)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (srfi srfi-67) default-compare)))
    (else (import (only (srfi 67) default-compare))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-compare.scm")))
    (else (include "labelinglogic-expression-compare.scm"))))
