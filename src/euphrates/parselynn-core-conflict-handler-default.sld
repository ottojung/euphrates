
(define-library
  (euphrates
    parselynn-core-conflict-handler-default)
  (export parselynn:core:conflict-handler/default)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base) begin define list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-core-conflict-handler-default.scm")))
    (else (include
            "parselynn-core-conflict-handler-default.scm"))))
