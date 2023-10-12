
(define-library
  (euphrates
    parselynn-singlechar-additional-grammar-rules)
  (export
    parselynn/singlechar:additional-grammar-rules)
  (import
    (only (euphrates parselynn-singlechar-struct)
          parselynn/singlechar-struct:additional-grammar-rules))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-singlechar-additional-grammar-rules.scm")))
    (else (include
            "parselynn-singlechar-additional-grammar-rules.scm"))))
