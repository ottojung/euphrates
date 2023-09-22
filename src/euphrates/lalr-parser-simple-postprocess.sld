
(define-library
  (euphrates lalr-parser-simple-postprocess)
  (export lalr-parser/simple:postprocess)
  (import
    (only (euphrates lalr-parser-simple-do-char-to-string)
          lalr-parser/simple-do-char->string))
  (import
    (only (euphrates lalr-parser-simple-struct)
          lalr-parser/simple-struct:transformations))
  (import
    (only (euphrates lalr-parser-simple-transform-result)
          lalr-parser/simple-transform-result))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-postprocess.scm")))
    (else (include "lalr-parser-simple-postprocess.scm"))))
