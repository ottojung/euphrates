
(define-library
  (euphrates
    parselynn-ll-compile-get-predictor-name)
  (export parselynn:ll-compile:get-predictor-name)
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          define
          string->symbol
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-compile-get-predictor-name.scm")))
    (else (include
            "parselynn-ll-compile-get-predictor-name.scm"))))
