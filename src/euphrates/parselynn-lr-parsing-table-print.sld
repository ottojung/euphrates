
(define-library
  (euphrates parselynn-lr-parsing-table-print)
  (export parselynn:lr-parsing-table:print)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates list-display-as-general-table)
          list:display-as-general-table))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import
    (only (euphrates parselynn-lr-accept-action)
          parselynn:lr-accept-action?))
  (import
    (only (euphrates parselynn-lr-goto-action)
          parselynn:lr-goto-action:target-id
          parselynn:lr-goto-action?))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:action:keys
          parselynn:lr-parsing-table:action:ref
          parselynn:lr-parsing-table:goto:keys
          parselynn:lr-parsing-table:goto:ref
          parselynn:lr-parsing-table:state:keys))
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
          append
          apply
          begin
          cadr
          car
          cond
          cons
          current-output-port
          define
          else
          if
          list
          map
          quote
          string-append
          values))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parsing-table-print.scm")))
    (else (include "parselynn-lr-parsing-table-print.scm"))))
