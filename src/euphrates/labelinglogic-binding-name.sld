
(define-library
  (euphrates labelinglogic-binding-name)
  (export labelinglogic::binding:name)
  (import
    (only (scheme base) begin define list-ref))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-binding-name.scm")))
    (else (include "labelinglogic-binding-name.scm"))))
