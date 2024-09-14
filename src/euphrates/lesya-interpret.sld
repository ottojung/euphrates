
(define-library
  (euphrates lesya-interpret)
  (export lesya:interpret)
  (import
    (only (euphrates lesya-language)
          lesya:language:begin
          lesya:language:cons
          lesya:language:run
          lesya:language:when))
  (import
    (only (scheme base) begin cons define quote when))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-interpret.scm")))
    (else (include "lesya-interpret.scm"))))
