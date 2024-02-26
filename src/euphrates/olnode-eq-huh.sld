
(define-library
  (euphrates olnode-eq-huh)
  (export olnode-eq?)
  (import (only (euphrates olgraph) olnode:id))
  (import (only (scheme base) begin define equal?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olnode-eq-huh.scm")))
    (else (include "olnode-eq-huh.scm"))))
