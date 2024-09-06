
(define-library
  (euphrates parselynn-lr-parse-conflict-print)
  (export parselynn:lr-parse-conflict:print)
  (import
    (only (euphrates parselynn-lr-action-print)
          parselynn:lr-action:print))
  (import
    (only (euphrates parselynn-lr-parse-conflict)
          parselynn:lr-parse-conflict:actions))
  (import
    (only (scheme base)
          begin
          car
          cdr
          current-output-port
          define
          for-each
          lambda))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parse-conflict-print.scm")))
    (else (include "parselynn-lr-parse-conflict-print.scm"))))
