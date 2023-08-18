
(define-library
  (euphrates lalr-parser-simple-flatten1)
  (export lalr-parser/simple-flatten1)
  (import
    (only (euphrates list-collapse) list-collapse))
  (import
    (only (scheme base) begin define string?))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-flatten1.scm")))
    (else (include "lalr-parser-simple-flatten1.scm"))))
