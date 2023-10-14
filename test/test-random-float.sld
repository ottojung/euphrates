
(define-library
  (test-random-float)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates random-float) random-float))
  (import (only (scheme base) < > begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-random-float.scm")))
    (else (include "test-random-float.scm"))))
