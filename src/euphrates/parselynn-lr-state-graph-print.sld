
(define-library
  (euphrates parselynn-lr-state-graph-print)
  (export parselynn:lr-state-graph:print)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates object-to-string)
          object->string))
  (import
    (only (euphrates parselynn-lr-state-graph-traverse)
          parselynn:lr-state-graph:traverse))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:print))
  (import
    (only (scheme base)
          begin
          current-output-port
          define
          for-each
          lambda
          newline))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-state-graph-print.scm")))
    (else (include "parselynn-lr-state-graph-print.scm"))))
