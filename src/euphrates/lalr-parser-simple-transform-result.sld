
(define-library
  (euphrates lalr-parser-simple-transform-result)
  (export lalr-parser/simple-transform-result)
  (import
    (only (euphrates lalr-parser-simple-do-flatten)
          lalr-parser/simple-do-flatten))
  (import
    (only (euphrates lalr-parser-simple-do-join)
          lalr-parser/simple-do-join))
  (import
    (only (euphrates lalr-parser-simple-do-skips)
          lalr-parser/simple-do-skips))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-transform-result.scm")))
    (else (include
            "lalr-parser-simple-transform-result.scm"))))
