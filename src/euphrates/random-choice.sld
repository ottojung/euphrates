
(define-library
  (euphrates random-choice)
  (export random-choice)
  (import
    (only (euphrates big-random-int) big-random-int)
    (only (scheme base)
          -
          <=
          begin
          cons
          define
          if
          let
          quote
          vector-length
          vector-ref))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/random-choice.scm")))
    (else (include "random-choice.scm"))))
