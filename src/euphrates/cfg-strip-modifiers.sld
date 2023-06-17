
(define-library
  (euphrates cfg-strip-modifiers)
  (export CFG-strip-modifiers)
  (import
    (only (euphrates cfg-parse-modifiers)
          CFG-parse-modifiers))
  (import
    (only (scheme base) begin define define-values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/cfg-strip-modifiers.scm")))
    (else (include "cfg-strip-modifiers.scm"))))
