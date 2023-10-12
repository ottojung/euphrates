
(define-library
  (euphrates parselynn-latin-letters)
  (export parselynn/latin/letters)
  (import
    (only (euphrates parselynn-latin-lowercases)
          parselynn/latin/lowercases))
  (import
    (only (euphrates parselynn-latin-uppercases)
          parselynn/latin/uppercases))
  (import (only (scheme base) append begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-latin-letters.scm")))
    (else (include "parselynn-latin-letters.scm"))))
