
(define-library
  (euphrates lalr-parser-conflict-handler-p)
  (export lalr-parser-conflict-handler/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-conflict-handler-p.scm")))
    (else (include "lalr-parser-conflict-handler-p.scm"))))
