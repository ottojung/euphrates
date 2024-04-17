
(define-library
  (euphrates parselynn-simple-join1)
  (export parselynn:simple:join1)
  (import
    (only (euphrates parselynn-simple-flatten1)
          parselynn:simple:flatten1))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          apply
          begin
          define
          map
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-join1.scm")))
    (else (include "parselynn-simple-join1.scm"))))
