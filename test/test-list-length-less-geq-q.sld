
(define-library
  (test-list-length-less-geq-q)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates list-length-geq-q)
          list-length=<?))
  (import
    (only (scheme base)
          begin
          cond-expand
          let
          not
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-length-less-geq-q.scm")))
    (else (include "test-list-length-less-geq-q.scm"))))
