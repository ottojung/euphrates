
(define-library
  (euphrates dynamic-thread-cancel-tag)
  (export dynamic-thread-cancel-tag)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-cancel-tag.scm")))
    (else (include "dynamic-thread-cancel-tag.scm"))))
