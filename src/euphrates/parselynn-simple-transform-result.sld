
(define-library
  (euphrates parselynn-simple-transform-result)
  (export parselynn/simple-transform-result)
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates comp) appcomp))
  (import
    (only (euphrates parselynn-simple-do-flatten)
          parselynn/simple-do-flatten))
  (import
    (only (euphrates parselynn-simple-do-inline)
          parselynn/simple-do-inline))
  (import
    (only (euphrates parselynn-simple-do-join)
          parselynn/simple-do-join))
  (import
    (only (euphrates parselynn-simple-do-skips)
          parselynn/simple-do-skips))
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-transform-result.scm")))
    (else (include
            "parselynn-simple-transform-result.scm"))))
