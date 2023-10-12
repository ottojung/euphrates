
(define-library
  (euphrates parselynn-simple-flatten1)
  (export parselynn/simple-flatten1)
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
               "euphrates/parselynn-simple-flatten1.scm")))
    (else (include "parselynn-simple-flatten1.scm"))))
