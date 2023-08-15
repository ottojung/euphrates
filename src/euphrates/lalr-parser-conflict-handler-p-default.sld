
(define-library
  (euphrates
    lalr-parser-conflict-handler-p-default)
  (export lalr-parser-conflict-handler/p-default)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base) begin define list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-conflict-handler-p-default.scm")))
    (else (include
            "lalr-parser-conflict-handler-p-default.scm"))))
