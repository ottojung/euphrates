
(define-library
  (euphrates parselynn-lr-action-print)
  (export parselynn:lr-action:print)
  (import (only (euphrates fprintf) fprintf))
  (import
    (only (euphrates parselynn-lr-accept-action)
          parselynn:lr-accept-action?))
  (import
    (only (euphrates parselynn-lr-goto-action)
          parselynn:lr-goto-action:target-id
          parselynn:lr-goto-action?))
  (import
    (only (euphrates parselynn-lr-reduce-action)
          parselynn:lr-reduce-action:production
          parselynn:lr-reduce-action?))
  (import
    (only (euphrates parselynn-lr-shift-action)
          parselynn:lr-shift-action:target-id
          parselynn:lr-shift-action?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          begin
          cadr
          car
          cond
          current-output-port
          define
          else
          list
          map
          quote))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-action-print.scm")))
    (else (include "parselynn-lr-action-print.scm"))))
