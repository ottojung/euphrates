
(define-library
  (euphrates labelinglogic-binding-make)
  (export labelinglogic::binding::make)
  (import (only (scheme base) begin define list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-binding-make.scm")))
    (else (include "labelinglogic-binding-make.scm"))))
