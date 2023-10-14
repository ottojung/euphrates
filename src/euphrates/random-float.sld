
(define-library
  (euphrates random-float)
  (export random-float)
  (import
    (only (euphrates big-random-int) big-random-int))
  (import (only (scheme base) + - / begin define))
  (import (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/random-float.scm")))
    (else (include "random-float.scm"))))
