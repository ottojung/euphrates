
(define-library
  (euphrates global-debug-mode-filter)
  (export global-debug-mode-filter)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/global-debug-mode-filter.scm")))
    (else (include "global-debug-mode-filter.scm"))))
