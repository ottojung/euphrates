
(define-library
  (euphrates parselynn-lr-parsing-table-print)
  (export parselynn:lr-parsing-table:print)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates list-display-as-general-table)
          list:display-as-general-table))
  (import
    (only (euphrates parselynn-lr-action-print)
          parselynn:lr-action:print))
  (import
    (only (euphrates parselynn-lr-parse-conflict-print)
          parselynn:lr-parse-conflict:print))
  (import
    (only (euphrates parselynn-lr-parse-conflict)
          parselynn:lr-parse-conflict?))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:action:keys
          parselynn:lr-parsing-table:action:ref
          parselynn:lr-parsing-table:goto:keys
          parselynn:lr-parsing-table:goto:ref
          parselynn:lr-parsing-table:state:keys))
  (import
    (only (euphrates parselynn-lr-reject-action)
          parselynn:lr-reject-action:make))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          append
          begin
          cond
          cons
          current-output-port
          define
          else
          list
          map
          values
          when))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parsing-table-print.scm")))
    (else (include "parselynn-lr-parsing-table-print.scm"))))
