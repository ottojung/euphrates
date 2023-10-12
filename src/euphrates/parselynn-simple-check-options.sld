
(define-library
  (euphrates parselynn-simple-check-options)
  (export parselynn/simple-check-options)
  (import (only (euphrates gkeyword) gkeyword?))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          car
          define
          list
          map
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-check-options.scm")))
    (else (include "parselynn-simple-check-options.scm"))))
