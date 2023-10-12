
(define-library
  (euphrates parselynn-simple-postprocess)
  (export parselynn/simple:postprocess)
  (import
    (only (euphrates parselynn-simple-do-char-to-string)
          parselynn/simple-do-char->string))
  (import
    (only (euphrates parselynn-simple-struct)
          parselynn/simple-struct:hidden-tree-labels
          parselynn/simple-struct:transformations))
  (import
    (only (euphrates parselynn-simple-transform-result)
          parselynn/simple-transform-result))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-postprocess.scm")))
    (else (include "parselynn-simple-postprocess.scm"))))
