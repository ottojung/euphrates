
(define-library
  (test-string-drop-n)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-drop-n) string-drop-n))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string-drop-n.scm")))
    (else (include "test-string-drop-n.scm"))))
